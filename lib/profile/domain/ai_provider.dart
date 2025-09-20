import 'package:flutter/cupertino.dart';
import 'package:nutri_care_mobile/models/chat_models/create_chat_sessions_response.dart';
import 'package:nutri_care_mobile/models/chat_models/get_all_messages_response.dart';
import 'package:nutri_care_mobile/models/chat_models/send_message_response.dart';
import '../../../network/api_service.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../models/chat_models/get_chat_sessions_response.dart';

class AiProvider extends ChangeNotifier {
  GetChatSessionsResponse getChatSessionsResponse = GetChatSessionsResponse();
  GetAllMessagesResponse getAllMessagesResponse = GetAllMessagesResponse();
  CreateChatSessionsResponse createChatSessionsResponse = CreateChatSessionsResponse();
  SendMessageResponse sendMessageResponse = SendMessageResponse();

  String? sessionId;
  bool messageSent = true;
  BuildContext? buildContext;

  final List<Map<String, String>> messages = [];

  void initContext(BuildContext context) {
    buildContext = context;
  }

  /// Get chat sessions and store the first sessionId if any.
  Future<void> getChatSessions() async {
    try {
      getChatSessionsResponse = await MyApi.callGetApi(
        url: getChatSessionsUrl,
        modelName: Models.getChatSessionsResponse,
      );

      if (getChatSessionsResponse.sessions?.isNotEmpty ?? false) {
        sessionId = getChatSessionsResponse.sessions!.first.id;
        await getAllMessages();
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error in getChatSessions: $e");
    }
  }

  /// Get all messages for the current session.
  Future<void> getAllMessages() async {
    if (sessionId == null) return;

    try {
      getAllMessagesResponse = await MyApi.callGetApi(
        url: "$baseUrl/api/chat/sessions/$sessionId",
        modelName: Models.getAllMessagesResponse,
      );

      messages.clear();
      getAllMessagesResponse.messages?.forEach((msg) {
        messages.add({
          "sender": msg.sender ?? '',
          "content": msg.content ?? '',
          "createdAt": msg.createdAt ?? ''
        });
      });

      notifyListeners();
    } catch (e) {
      debugPrint("Error in getAllMessages: $e");
    }
  }

  /// Create a new session with the first user message as the title.
  Future<void> createChatSession(String title) async {
    try {
      final body = {"title": title};
      createChatSessionsResponse = await MyApi.callPostApi(
        url: createChatSessionsUrl,
        body: body,
        modelName: Models.createChatSessionsResponse,
        sendToken: true
      );

      sessionId = createChatSessionsResponse.session?.id;

      notifyListeners();
    } catch (e) {
      debugPrint("Error in createChatSession: $e");
    }
  }

  /// Send message to the session.
  Future<void> sendMessage(String userMessage) async {
    if (sessionId == null) {
      debugPrint("Session ID is null while sending message! Creating new session...");

      // Try to create session with first message as title
      await createChatSession(userMessage);

      if (sessionId == null) {
        debugPrint("Failed to create session. Cannot send message.");
        return;
      }

      // 🚨 The session is now created → call sendMessage **again**
      await sendMessage(userMessage);
      return;
    }

    // Add user message immediately
    messages.add({
      "sender": "user",
      "content": userMessage,
      "createdAt": DateTime.now().toIso8601String(),
    });
    messageSent = false;
    notifyListeners();

    // Add placeholder for assistant reply
    messages.add({
      "sender": "assistant",
      "content": "",
      "createdAt": DateTime.now().toIso8601String(),
      "loading": "true",
    });
    notifyListeners();

    try {
      final body = {"message": userMessage};
      sendMessageResponse = await MyApi.callPostApi(
        url: "$baseUrl/api/chat/sessions/$sessionId/messages",
        body: body,
        sendToken: true,
        modelName: Models.sendMessageResponse,
      );

      // Replace loading assistant message
      final index = messages.lastIndexWhere(
            (msg) => msg['sender'] == 'assistant' && msg['loading'] == 'true',
      );

      if (index != -1) {
        messages[index] = {
          "sender": "assistant",
          "content": sendMessageResponse.reply ?? '',
          "createdAt": DateTime.now().toIso8601String(),
          "loading": "false",
        };
      }

      messageSent = true;
      notifyListeners();
    } catch (e) {
      debugPrint("Error in sendMessage: $e");

      messages.removeWhere(
            (msg) => msg['sender'] == 'assistant' && msg['loading'] == 'true',
      );

      messageSent = true;
      notifyListeners();
    }
  }
}

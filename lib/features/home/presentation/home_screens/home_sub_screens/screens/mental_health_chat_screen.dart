import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/res/res.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../profile/domain/ai_provider.dart';
import 'package:intl/intl.dart';
import '../../../../../../res/common_widgets.dart';
class MentalHealthChatScreen extends StatefulWidget {
  const MentalHealthChatScreen({super.key});

  @override
  _MentalHealthChatScreenState createState() => _MentalHealthChatScreenState();
}

class _MentalHealthChatScreenState extends State<MentalHealthChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final aiProvider = Provider.of<AiProvider>(context, listen: false);
      aiProvider.initContext(context);
      aiProvider.getChatSessions();
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AiProvider>(context);
    initializeResources(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading:false,
        elevation: 0.5,
        title: CustomText(
          text: "AI Mental Health Coach",
          fontWeight: FontWeight.normal,
          fontSize: sizes?.fontSize24,
          alignment: Alignment.center,
          color: AppColors.blackTextColor,
          fontFamily: 'Inter Tight',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              controller: _scrollController,
              itemCount: aiProvider.messages.length,
              itemBuilder: (context, index) {
                final message = aiProvider.messages[index];
                final isUser = message['sender'] == 'user';

                // Parse createdAt
                final createdAtString = message['createdAt'] ?? '';
                final createdAt = DateTime.tryParse(createdAtString);
                final formattedTime = createdAt != null
                    ? DateFormat.jm().format(createdAt) // e.g. 4:33 PM
                    : '';
                print("message['loading']--->${message['loading']}");
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        message['loading'] == 'true'
                            ? Skeletonizer(
                          child: Container(
                            width: sizes!.width,
                            // height: 100,
                            color: Colors.grey.shade200,
                            child: CustomText(
                             text: "Thank you for using nutri care app. I am pretty sure you'll be happy after using our app. Your message is being sent, please wait until you receive it. Thanks!",
                              fontWeight: FontWeight.normal,
                              fontSize: sizes?.fontSize12,
                              alignment: Alignment.centerLeft,
                              lines: 3,
                              color: AppColors.blackTextColor,
                              fontFamily: 'Inter Tight',                            ),
                          ),
                        )
                            : CustomText(
                         text:  message['content'] ?? '',
                          fontWeight: FontWeight.normal,
                          fontSize: sizes?.fontSize12,
                          lines: 1000,
                          color: AppColors.blackTextColor,
                          fontFamily: 'Inter Tight',                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontFamily: 'Inter Tight',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },

            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(0, -1),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: aiProvider.messageSent
                          ?  Icon(Icons.send, color: AppColors.primaryColor)
                          :  Icon(Icons.motion_photos_pause_outlined, color: AppColors.greyTextColor),
                      onPressed: () async {
                        _scrollToBottom();

                        final text = _messageController.text.trim();
                        _messageController.clear();
                        if (text.isEmpty) return;

                        if (aiProvider.sessionId == null) {
                          final words = text.split(' ');
                          final title = words.take(5).join(' ');
                          await aiProvider.createChatSession(title);
                        }

                        await aiProvider.sendMessage(text);
                        _scrollToBottom();

                      },
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CustomText(
                    text: "⚠️ This response is generated by AI and we are not responsible for any consequences.",
                    fontWeight: FontWeight.normal,
                    fontSize: sizes?.fontSize12,
                    alignment: Alignment.centerLeft,
                    lines: 3,
                    color: AppColors.blackTextColor,
                    fontFamily: 'Inter Tight',
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

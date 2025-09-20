import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/widgets/custom_app_bar.dart';
import 'package:nutri_care_mobile/features/notifications/notification_widget/notification_widget.dart';
import '../../../network/api_url.dart';
import '../../../res/strings.dart';
import '../../../res/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String message;
  final bool isRead;
  final DateTime? createdAt;

  AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: (json['id'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      isRead: json['isRead'] == true,
      createdAt: _tryParseDate(json['createdAt']),
    );
  }

  static DateTime? _tryParseDate(dynamic v) {
    if (v == null) return null;
    try {
      return DateTime.tryParse(v.toString());
    } catch (_) {
      return null;
    }
  }
}

class NotificationsApi {
  static Future<List<AppNotification>> fetch({
    String? token, // optional auth
  }) async {
    final uri = Uri.parse('$baseUrl/api/notifications/');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': '$token',
      },
    );

    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
    }

    final data = jsonDecode(resp.body);
    final list = (data['notifications'] as List? ?? [])
        .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }
}

// TODO: set your actual baseUrl and token source.

String? get authToken => PreferenceUtils.getString(Strings.accessToken);

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<AppNotification>> _future;

  @override
  void initState() {
    super.initState();
    _future = NotificationsApi.fetch(token: authToken);
  }

  String _relativeTime(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        onBackPressed: () => Navigator.pop(context),
        title: "Notifications",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<AppNotification>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // skeleton/loader
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Failed to load: ${snapshot.error}'));
            }
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const Center(child: Text('No notifications'));
            }

            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final n = items[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: NotificationWidget(
                    title: n.title,
                    subtitle: n.message,
                    time: _relativeTime(n.createdAt),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//
// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({super.key});
//
//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }
//
// class _NotificationsScreenState extends State<NotificationsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: CustomAppBar(
//         onBackPressed: (){
//           Navigator.pop(context);
//         },
//         title: "Notifications",
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(16.0),
//         child:  SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: sizes?.width,
//                 height: sizes?.height,
//                 decoration: BoxDecoration(
//                     color: AppColors.greyColor,
//                     borderRadius: BorderRadius.circular(12)
//                 ),
//                 child: Column(
//                   children: [
//                     const NotificationWidget(
//                         title: "Track Family Health Together",
//                         subtitle: "Use the Family Health Dashboard to monitor and plan meals and activities for everyone.",
//                         time: "4h ago"
//                     ),
//                     SizedBox(height: sizes?.smallPadding),
//                     const NotificationWidget(
//                         title: "Track Family Health Together",
//                         subtitle: "Use the Family Health Dashboard to monitor and plan meals and activities for everyone.",
//                         time: "4h ago"
//                     ),
//                     SizedBox(height: sizes?.smallPadding),
//                     const NotificationWidget(
//                         title: "Track Family Health Together",
//                         subtitle: "Use the Family Health Dashboard to monitor and plan meals and activities for everyone.",
//                         time: "4h ago"
//                     ),
//                     SizedBox(height: sizes?.smallPadding),
//                     const NotificationWidget(
//                         title: "Track Family Health Together",
//                         subtitle: "Use the Family Health Dashboard to monitor and plan meals and activities for everyone.",
//                         time: "4h ago"
//                     ),
//                     SizedBox(height: sizes?.smallPadding),
//                     const NotificationWidget(
//                         title: "Track Family Health Together",
//                         subtitle: "Use the Family Health Dashboard to monitor and plan meals and activities for everyone.",
//                         time: "4h ago"
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ) ,
//     );
//   }
// }

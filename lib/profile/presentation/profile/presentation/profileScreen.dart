// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../res/assets.dart';
import '../../../../res/common_widgets.dart';
import '../../../../res/strings.dart';
import '../../../../res/utils.dart';
import '../widgets/profile_card_widget.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  ProfilescreenState createState() => ProfilescreenState();
}

class ProfilescreenState extends State<Profilescreen> {
  final List<Map<String, dynamic>> _cardsData = [
    {
      "icon": Assets.securityAndPrivacyPolicy,
      "title": "Security & Privacy Policy",
      "route": AppRoutes.securityAndPrivacyPolicyScreen,
    },
    {
      "icon": Assets.logout,
      "title": "Logout",
      "route": "logout",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 55),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ProfileAvatar(
                          networkImageUrl: PreferenceUtils.getString(Strings.profilePicture) ?? "",
                          assetImagePath: Assets.profileImage,
                          radius: 30.0,
                        ),
                        Positioned(
                          bottom: 0,
                          right: -4,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.editProfileScreen);
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (PreferenceUtils.getString(Strings.userName)?.isNotEmpty == true)
                              ? PreferenceUtils.getString(Strings.userName)!
                              : "Abdullah Shahbaz",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          (PreferenceUtils.getString(Strings.email)?.isNotEmpty == true)
                              ? PreferenceUtils.getString(Strings.email)!
                              : "theabdullahshahbaz@gmail.com",                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: _cardsData.map((card) {
                    return ProfileCardWidget(
                      icon: card["icon"],
                      title: card["title"],
                      onTap: () {
                        if (card["route"] == "logout") {
                          // Clear user preferences
                          PreferenceUtils.clearPreferences();

                          // Navigate to login screen
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.signIn,
                            (route) => false, // Remove all routes in the stack
                          );
                        } else {
                          Navigator.pushNamed(context, card["route"]);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

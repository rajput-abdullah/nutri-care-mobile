// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import 'package:nutri_care_mobile/core/widgets/input_field.dart';
import 'package:nutri_care_mobile/features/auth/domain/signup_provider.dart';
import 'package:provider/provider.dart';
import '../../../../res/assets.dart';
import '../../../../res/common_widgets.dart';
import '../../../../res/strings.dart';
import '../../../../res/utils.dart';
import '../../nutrition/domain/nutrition_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NutritionProvider>(context, listen: false).getUserData();
    });

  }
  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    signupProvider.init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 35),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back, size: 36,),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: SvgPicture.asset(
                    Assets.appLogo,
                    height: 30,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Please update your details to continue.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ProfileAvatarCustom(
                              // Local preview right after pick:
                              localImageFile: signupProvider.profileImage != null
                                  ? File(signupProvider.profileImage!.path)
                                  : null,
                              // Fallback to network (full URL):
                              networkImageUrl: signupProvider.imageUrl ??
                                  PreferenceUtils.getString(Strings.profilePicture)??"",
                              assetImagePath: Assets.privacyImage,
                              radius: 50.0,
                            ),
                            GestureDetector(
                              onTap: signupProvider.showImagePickerOptions,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFD6DA5D),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        InputField(
                          controller: signupProvider.fullNameController,
                          label:PreferenceUtils.getString(Strings.name)??"Full Name",
                          keyboardType: TextInputType.name,
                          fillColor: Colors.transparent,
                            enabled:false

                        ),
                        SizedBox(height: 16),
                        InputField(
                          controller: signupProvider.emailController,
                          label:PreferenceUtils.getString(Strings.email)??"Email",
                          keyboardType: TextInputType.emailAddress,
                          fillColor: Colors.transparent,
                            enabled:false
                        ),
                        SizedBox(height: 16),
                        InputField(
                          controller: signupProvider.passwordController,
                          label: "Password",
                          obscureText: !signupProvider.isPasswordVisible,
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            icon: Icon(
                              signupProvider.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                signupProvider.isPasswordVisible =
                                    !signupProvider.isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        InputField(
                          controller: signupProvider.confirmPasswordController,
                          label: "Confirm Password",
                          obscureText: !signupProvider.isConfirmPasswordVisible,
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            icon: Icon(
                              signupProvider.isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                signupProvider.isConfirmPasswordVisible =
                                    !signupProvider.isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            label: "Next",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.assessmentScreen,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


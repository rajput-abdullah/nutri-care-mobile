// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/theme/app_text_styles.dart';
import 'package:nutri_care_mobile/core/widgets/custom_app_bar.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../domain/signup_provider.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyCodeScreen({required this.phoneNumber});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  // TextEditingController _controller1 = TextEditingController();
  // TextEditingController _controller2 = TextEditingController();
  // TextEditingController _controller3 = TextEditingController();
  // TextEditingController _controller4 = TextEditingController();
  //
  // FocusNode _focusNode1 = FocusNode();
  // FocusNode _focusNode2 = FocusNode();
  // FocusNode _focusNode3 = FocusNode();
  // FocusNode _focusNode4 = FocusNode();
  String pin = "";

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    signupProvider.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onBackPressed: (){
          Navigator.pop(context);
        },
        backButtonColor: AppColors.greyShadeColor,
        backgroundColor: AppColors.whiteColor,
        title: "Verify Your Phone",
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: AppColors.whiteColor
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft, // Align to top-left
                  child: Text(
                    "Verify Your OTP",
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.topLeft, // Align to top-left
                  child: Text(
                    "Please enter the 4 digit code sent to ${widget.phoneNumber}",
                    style: AppTextStyles.subheading.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyTextColor
                    ),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                ),
                SizedBox(height: 40),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     OtpField(
                //       controller: _controller1,
                //       focusNode: _focusNode1,
                //       nextFocusNode: _focusNode2,
                //     ),
                //     SizedBox(width: 10),
                //     OtpField(
                //       controller: _controller2,
                //       focusNode: _focusNode2,
                //       nextFocusNode: _focusNode3,
                //     ),
                //     SizedBox(width: 10),
                //     OtpField(
                //       controller: _controller3,
                //       focusNode: _focusNode3,
                //       nextFocusNode: _focusNode4,
                //     ),
                //     SizedBox(width: 10),
                //     OtpField(
                //       controller: _controller4,
                //       focusNode: _focusNode4,
                //     ),
                //   ],
                // ),
                Pinput(
                  defaultPinTheme: PinTheme(
                    width: 72,
                    height: 78,
                    textStyle: TextStyle(fontSize: 16),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.greyColor, width: 1.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    pin = value;
                  },
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primarySecondColor
                        ]
                    ),
                    label: "Continue",
                    onPressed: () {
                      // String code = _controller1.text +
                      //     _controller2.text +
                      //     _controller3.text +
                      //     _controller4.text;
                      if (pin.length == 4) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Verifying code: $pin")),
                        );
                        if (pin == "9999") {
                          signupProvider.verifyEmailOtpApi(
                            verificationType: "phone",
                            identifier: widget.phoneNumber,
                            otpCode: pin,
                          );
                        }
                      }
                       else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Please enter a 4-digit code")),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

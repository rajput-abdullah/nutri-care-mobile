
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/theme/app_text_styles.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import 'package:nutri_care_mobile/core/widgets/otp_field.dart';
import 'package:provider/provider.dart';

import '../../domain/signup_provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  const EmailVerificationScreen({required this.email});

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  FocusNode _focusNode6 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    signupProvider.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        foregroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Verify Your Email",
          style: AppTextStyles.heading,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  "Verify Your Email",
                  style: AppTextStyles.heading,
                ),
                SizedBox(height: 8),
                Text(
                  "Enter the 6-digit code sent to ${widget.email}",
                  style: AppTextStyles.subheading,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpField(
                      controller: _controller1,
                      focusNode: _focusNode1,
                      nextFocusNode: _focusNode2,
                      previousFocusNode: null, // First field, no previous node
                    ),
                    SizedBox(width: 10),
                    OtpField(
                      controller: _controller2,
                      focusNode: _focusNode2,
                      nextFocusNode: _focusNode3,
                      previousFocusNode: _focusNode1, // Previous is the first field
                    ),
                    SizedBox(width: 10),
                    OtpField(
                      controller: _controller3,
                      focusNode: _focusNode3,
                      nextFocusNode: _focusNode4,
                      previousFocusNode: _focusNode2, // Previous is the second field
                    ),
                    SizedBox(width: 10),
                    OtpField(
                      controller: _controller4,
                      focusNode: _focusNode4,
                      nextFocusNode: _focusNode5, // Last field, no next node
                      previousFocusNode: _focusNode3, // Previous is the third field
                    ),
                    SizedBox(width: 10),
                    OtpField(
                      controller: _controller5,
                      focusNode: _focusNode5,
                      nextFocusNode: _focusNode6, // Last field, no next node
                      previousFocusNode: _focusNode4, // Previous is the third field
                    ),
                    SizedBox(width: 10),
                    OtpField(
                      controller: _controller6,
                      focusNode: _focusNode6,
                      nextFocusNode: null, // Last field, no next node
                      previousFocusNode: _focusNode5, // Previous is the third field
                    ),
                  ],
                ),
                SizedBox(height: 90),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    label: "Continue",
                    onPressed: () {
                      String code = _controller1.text +
                          _controller2.text +
                          _controller3.text +
                          _controller4.text +
                          _controller5.text +
                          _controller6.text;

                      if (code.length == 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Verifying code: $code")),
                        );
                        signupProvider.verifyEmailOtpApi(
                          verificationType: "email",
                          identifier: widget.email,
                          otpCode: code,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter a 6-digit code"),
                          ),
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

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }
}
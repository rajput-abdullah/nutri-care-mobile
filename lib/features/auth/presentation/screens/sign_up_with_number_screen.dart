import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nutri_care_mobile/core/theme/app_text_styles.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../domain/signup_provider.dart';

class SignUpWithPhone extends StatefulWidget {
  const SignUpWithPhone({super.key});

  @override
  _SignUpWithPhoneState createState() => _SignUpWithPhoneState();
}

class _SignUpWithPhoneState extends State<SignUpWithPhone> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN'); // Default India

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SignupProvider>(context, listen: false).init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sign Up with Phone",
                          style: AppTextStyles.heading,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Please enter your details to continue.",
                          style: AppTextStyles.subheading,
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  // Country Code Picker
                                  SizedBox(
                                    width: 130, // Fixed width for country code picker
                                    child: InternationalPhoneNumberInput(
                                      onInputChanged: (PhoneNumber number) {
                                        setState(() {
                                          _phoneNumber = number;
                                        });
                                        signupProvider.completePhoneNumber = number.phoneNumber;
                                      },
                                      selectorConfig: const SelectorConfig(
                                        selectorType: PhoneInputSelectorType.DROPDOWN,
                                        setSelectorButtonAsPrefixIcon: true,
                                        showFlags: true,
                                        leadingPadding: 12,
                                        trailingSpace: false,
                                      ),
                                      initialValue: _phoneNumber,
                                      textFieldController: signupProvider.phoneController,
                                      formatInput: true,
                                      keyboardType: TextInputType.phone,
                                      inputDecoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                                      ),
                                      spaceBetweenSelectorAndTextField: 8,
                                      selectorTextStyle: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  // Vertical Divider
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  // Phone Number Input
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: TextFormField(
                                        controller: signupProvider.phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          hintText: "00 0000000000",
                                          border: InputBorder.none,
                                        ),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            label: "Sign Up",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String phone = signupProvider.completePhoneNumber ?? '';
                                if (phone.isNotEmpty) {
                                  signupProvider.phoneSignupApi();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please enter a valid phone number")),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
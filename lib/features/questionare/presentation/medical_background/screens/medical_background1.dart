import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/custom_app_bar.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:nutri_care_mobile/res/utils.dart';
import 'package:provider/provider.dart';
import '../../../domain/medical_background_provider.dart';

class MedicalBackground1 extends StatefulWidget {
  const MedicalBackground1({Key? key}) : super(key: key);

  @override
  _MedicalBackground1State createState() => _MedicalBackground1State();
}

class _MedicalBackground1State extends State<MedicalBackground1> {
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicalBackgroundProvider =
    Provider.of<MedicalBackGroundProvider>(context);
    medicalBackgroundProvider.initContext(context: context);
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () {},
        title: 'Medical background',
        backgroundColor: AppColors.whiteColor,
        backButtonColor: AppColors.greyShadeColor,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProgressIndicatorWidget(
              currentStep: 0,
              totalSteps: 6,
              stepWidth: 50,
            ),
            SizedBox(height: 50),
            Text(
                  'Do you have any diagnosed medical condition?',
              style: TextStyle(fontSize: 22, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: medicalBackgroundProvider.selectedConditions
                  .map((condition) {
                return Chip(
                  label: Text(condition),
                  onDeleted: () {
                    setState(() {
                      medicalBackgroundProvider.selectedConditions
                          .remove(condition);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                TextField(
                  focusNode: _textFieldFocusNode,
                  controller:
                  medicalBackgroundProvider.medicalConditionController,
                  onSubmitted: (text) {
                    _addMedicalCondition(text);
                  },
                  onChanged: (text) {
                    // Handle text changes if needed
                  },
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  minLines: 4,
                  decoration: InputDecoration(
                    hintText:
                    'Please enter your diagnosed medical conditions (if any).',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 95, 132, 146),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: medicalBackgroundProvider.selectedConditions.isEmpty
                          ? 10
                          : 9, // Adjust padding based on whether there are chips
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 8,
                  child: Text(
                    "${medicalBackgroundProvider.selectedConditions.length} Selected",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColors.primaryColor),
                      padding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.assessmentScreen);
                    },
                    child: Text(
                      'Previous',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (medicalBackgroundProvider
                          .selectedConditions.isNotEmpty) {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.medicalBackground2Screen,
                            arguments:
                            medicalBackgroundProvider.currentStep + 1);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Please add at least one medical condition.")),
                        );
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addMedicalCondition(String text) {
    if (text.trim().isNotEmpty) {
      final medicalBackgroundProvider =
      context.read<MedicalBackGroundProvider>();

      // Check if the condition is not already added
      if (!medicalBackgroundProvider.selectedConditions.contains(text.trim())) {
        setState(() {
          medicalBackgroundProvider.selectedConditions.add(text.trim());
          medicalBackgroundProvider.medicalConditionController.clear();
          // Refocus the text field after adding
          FocusScope.of(context).requestFocus(_textFieldFocusNode);
        });
      } else {
        // Show a message if the condition is already added
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("This condition is already added")),
        );
      }
    }
  }
}
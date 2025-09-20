// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:nutri_care_mobile/features/questionare/widgets/yes_no_buttons_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/diet_and_nutrition_provider.dart';

class DietNutritionScreen3 extends StatefulWidget {
  const DietNutritionScreen3({Key? key}) : super(key: key);

  @override
  _DietNutritionScreen3State createState() => _DietNutritionScreen3State();
}

class _DietNutritionScreen3State extends State<DietNutritionScreen3> {
  final FocusNode _textFieldFocusNode = FocusNode();
  final TextEditingController _foodIntoleranceController = TextEditingController();

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _foodIntoleranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietAndNutritionProvider>(context);
    dietProvider.initContext(context: context);
    dietProvider.currentStep = 1;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              'Diet and Nutrition Preferences',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            ProgressIndicatorWidget(
              currentStep: dietProvider.currentStep,
              totalSteps: 7,
            ),
            SizedBox(height: 50),
            Text(
              'Do you have any food intolerances or sensitivities?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            YesNoButtonsWidget(
              selectedOption: dietProvider.selectedOptionForFoodIntolerance ?? '',
              onOptionSelected: (option) {
                setState(() {
                  dietProvider.selectedOptionForFoodIntolerance = option;
                });
              },
            ),
            SizedBox(height: 20),

            /// Chips for added intolerances
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: dietProvider.selectedConditionsForFoodIntolerance
                  .map((condition) {
                return Chip(
                  label: Text(condition),
                  onDeleted: () {
                    setState(() {
                      dietProvider.selectedConditionsForFoodIntolerance.remove(condition);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            /// Text field
            Stack(
              children: [
                TextField(
                  focusNode: _textFieldFocusNode,
                  controller: _foodIntoleranceController,
                  onSubmitted: (text) {
                    _addFoodIntolerance(text);
                  },
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  minLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter any food intolerances or sensitivities.',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 95, 132, 146),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: dietProvider.selectedConditionsForFoodIntolerance.isEmpty ? 10 : 9,
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
                    "${dietProvider.selectedConditionsForFoodIntolerance.length} Selected",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Spacer(),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColors.primaryColor),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (dietProvider.currentStep > 0) {
                        setState(() {
                          dietProvider.currentStep--;
                        });
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.dietNurtion2,
                      );
                    },
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if(dietProvider.selectedOptionForFoodIntolerance=="Yes")
                     {
                       if (dietProvider.selectedConditionsForFoodIntolerance.isNotEmpty) {
                         setState(() {
                           dietProvider.currentStep++;
                         });
                         Navigator.pushReplacementNamed(
                           context,
                           AppRoutes.dietNurtion4,
                         );
                       } else {
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                               content: Text(
                                   "Please add at least one food intolerance or sensitivity.")),
                         );
                       }
                     }
                      else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.dietNurtion4,
                        );
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
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

  void _addFoodIntolerance(String text) {
    final trimmedText = text.trim();
    final dietProvider = context.read<DietAndNutritionProvider>();
    if (trimmedText.isNotEmpty) {
      if (!dietProvider.selectedConditionsForFoodIntolerance.contains(trimmedText)) {
        setState(() {
          dietProvider.selectedConditionsForFoodIntolerance.add(trimmedText);
          _foodIntoleranceController.clear();
          FocusScope.of(context).requestFocus(_textFieldFocusNode);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("This intolerance is already added")),
        );
      }
    }
  }
}

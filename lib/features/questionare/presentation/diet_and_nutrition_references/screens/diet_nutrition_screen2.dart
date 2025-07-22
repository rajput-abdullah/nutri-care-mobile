// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:nutri_care_mobile/features/questionare/domain/diet_and_nutrition_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../core/widgets/radio_widget.dart';

class DietNutritionScreen2 extends StatefulWidget {
  const DietNutritionScreen2({Key? key}) : super(key: key);

  @override
  _DietNutritionScreen2State createState() => _DietNutritionScreen2State();
}

class _DietNutritionScreen2State extends State<DietNutritionScreen2> {
  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietAndNutritionProvider>(context);
    dietProvider.initContext(context: context);
    dietProvider.currentStep = 0;
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
                currentStep: dietProvider.currentStep, totalSteps: 7),
            SizedBox(height: 50),
            Text(
              'What type of diet do you prefer?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RadioOptionTile(
              title: 'Traditional',
              isSelected: dietProvider.selectedValuesForTypeOfDiet.contains('TRD'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!dietProvider.selectedValuesForTypeOfDiet.contains('TRD')) {
                      dietProvider.selectedValuesForTypeOfDiet.add('TRD');
                    }
                  } else {
                    dietProvider.selectedValuesForTypeOfDiet.remove('TRD');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Vegetarian',
              isSelected: dietProvider.selectedValuesForTypeOfDiet.contains('VGN'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!dietProvider.selectedValuesForTypeOfDiet.contains('VGN')) {
                      dietProvider.selectedValuesForTypeOfDiet.add('VGN');
                    }
                  } else {
                    dietProvider.selectedValuesForTypeOfDiet.remove('VGN');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Pescatarian',
              isSelected: dietProvider.selectedValuesForTypeOfDiet.contains('PSC'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!dietProvider.selectedValuesForTypeOfDiet.contains('PSC')) {
                      dietProvider.selectedValuesForTypeOfDiet.add('PSC');
                    }
                  } else {
                    dietProvider.selectedValuesForTypeOfDiet.remove('PSC');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Keto',
              isSelected: dietProvider.selectedValuesForTypeOfDiet.contains('KETO'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!dietProvider.selectedValuesForTypeOfDiet.contains('KETO')) {
                      dietProvider.selectedValuesForTypeOfDiet.add('KETO');
                    }
                  } else {
                    dietProvider.selectedValuesForTypeOfDiet.remove('KETO');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Paleo',
              isSelected: dietProvider.selectedValuesForTypeOfDiet.contains('PAL'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!dietProvider.selectedValuesForTypeOfDiet.contains('PAL')) {
                      dietProvider.selectedValuesForTypeOfDiet.add('PAL');
                    }
                  } else {
                    dietProvider.selectedValuesForTypeOfDiet.remove('PAL');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Gluten-Free',
              isSelected: dietProvider.selectedValuesForTypeOfDiet.contains('GLF'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!dietProvider.selectedValuesForTypeOfDiet.contains('GLF')) {
                      dietProvider.selectedValuesForTypeOfDiet.add('GLF');
                    }
                  } else {
                    dietProvider.selectedValuesForTypeOfDiet.remove('GLF');
                  }
                });
              },
            ),



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
                      if (dietProvider.currentStep > 0) {
                        setState(() {
                          dietProvider.currentStep--;
                        });
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.dietNurtion1,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (dietProvider.selectedValuesForTypeOfDiet.isNotEmpty) {
                        setState(() {
                          dietProvider.currentStep++;
                        });
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.dietNurtion3,
                          arguments: dietProvider.currentStep + 1,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select at least one option.'),
                          ),
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
}

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:nutri_care_mobile/core/widgets/radio_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/diet_and_nutrition_provider.dart';

class DietNutritionScreen8 extends StatefulWidget {
  const DietNutritionScreen8({Key? key}) : super(key: key);

  @override
  _DietNutritionScreen8State createState() => _DietNutritionScreen8State();
}

class _DietNutritionScreen8State extends State<DietNutritionScreen8> {
  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietAndNutritionProvider>(context);
    dietProvider.initContext(context: context);
    dietProvider.currentStep = 6;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              'Diet and Nutrition  ',
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
              'Are there specific types of foods or nutrients you’d like to focus on?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RadioOptionTile(
              title: 'High Protein',
              isSelected:
                  dietProvider.selectedValueForNutrientPreference == 'high_protein',
              onChanged: (bool? value) {
                setState(() {
                  dietProvider.selectedValueForNutrientPreference =
                      value! ? 'high_protein' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Low Carb',
              isSelected:
                  dietProvider.selectedValueForNutrientPreference == 'low_carb',
              onChanged: (bool? value) {
                setState(() {
                  dietProvider.selectedValueForNutrientPreference =
                      value! ? 'low_carb' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Fiber-Rich',
              isSelected:
                  dietProvider.selectedValueForNutrientPreference == 'fiber_rich',
              onChanged: (bool? value) {
                setState(() {
                  dietProvider.selectedValueForNutrientPreference =
                      value! ? 'fiber_rich' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Heart-Healthy',
              isSelected:
                  dietProvider.selectedValueForNutrientPreference == 'heart_healthy',
              onChanged: (bool? value) {
                setState(() {
                  dietProvider.selectedValueForNutrientPreference =
                      value! ? 'heart_healthy' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Immune-Boosting',
              isSelected:
                  dietProvider.selectedValueForNutrientPreference == 'immune_boosting',
              onChanged: (bool? value) {
                setState(() {
                  dietProvider.selectedValueForNutrientPreference =
                      value! ? 'immune_boosting' : null;
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
                        AppRoutes.dietNurtion6,
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
                    onPressed: () async {
                      print(
                          "dietProvider.selectedValueForNutrientPreference-->${dietProvider.selectedValueForNutrientPreference}");

                      if (dietProvider.selectedValueForNutrientPreference !=
                              null ||
                          dietProvider.selectedValueForNutrientPreference !=
                              '') {
                        setState(() {
                          dietProvider.currentStep++;
                        });
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.fitnessAndPhysicalActitvity1,
                          arguments: dietProvider.currentStep + 1,
                        );
                        // dietProvider
                        //     .saveDietPreference(profileId: profileId)
                        //     .then((value) {
                        //   if (value) {
                        //     Navigator.pushReplacementNamed(
                        //       context,
                        //       AppRoutes.fitnessAndPhysicalActitvity1,
                        //       arguments: dietProvider.currentStep + 1,
                        //     );
                        //   }
                        // });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select '),
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

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:nutri_care_mobile/core/widgets/radio_widget.dart';
import 'package:nutri_care_mobile/res/utils.dart';
import 'package:provider/provider.dart';

import '../../../domain/fitness_and_physical_activity_provider.dart';

class FitnessAndPhysicalActitvityScreen7 extends StatefulWidget {
  const FitnessAndPhysicalActitvityScreen7({Key? key}) : super(key: key);

  @override
  _FitnessAndPhysicalActitvityScreen7State createState() =>
      _FitnessAndPhysicalActitvityScreen7State();
}

class _FitnessAndPhysicalActitvityScreen7State
    extends State<FitnessAndPhysicalActitvityScreen7> {
  @override
  Widget build(BuildContext context) {
    final fitnessProvider =
        Provider.of<FitnessAndPhysicalActivityProvider>(context);
    fitnessProvider.initContext(context: context);
    fitnessProvider.currentStep = 5;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              'Fitness and Physical Activity',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            ProgressIndicatorWidget(
                currentStep: fitnessProvider.currentStep, totalSteps: 4),
            SizedBox(height: 50),
            Text(
              'What is your body type goal?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RadioOptionTile(
              title: 'Lean and Toned',
              isSelected:
                  fitnessProvider.selectedValueForBodyType == 'lean_and_toned',
              onChanged: (bool? value) {
                setState(() {
                  fitnessProvider.selectedValueForBodyType =
                      value! ? 'lean_and_toned' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Slim and Fit',
              isSelected:
                  fitnessProvider.selectedValueForBodyType == 'slim_and_fit',
              onChanged: (bool? value) {
                setState(() {
                  fitnessProvider.selectedValueForBodyType =
                      value! ? 'slim_and_fit' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Curvy and Healthy',
              isSelected:
                  fitnessProvider.selectedValueForBodyType == 'curvy_and_healthy',
              onChanged: (bool? value) {
                setState(() {
                  fitnessProvider.selectedValueForBodyType =
                      value! ? 'curvy_and_healthy' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Athletic and Endurance-Focused',
              isSelected: fitnessProvider.selectedValueForBodyType ==
                  'athletic_and_endurance_focused',
              onChanged: (bool? value) {
                setState(() {
                  fitnessProvider.selectedValueForBodyType =
                      value! ? 'athletic_and_endurance_focused' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Balanced and Proportional',
              isSelected: fitnessProvider.selectedValueForBodyType ==
                  'balanced_and_proportional',
              onChanged: (bool? value) {
                setState(() {
                  fitnessProvider.selectedValueForBodyType =
                      value! ? 'balanced_and_proportional' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'Rehabilitation and Recovery',
              isSelected: fitnessProvider.selectedValueForBodyType ==
                  'rehabilitation_and_recovery',
              onChanged: (bool? value) {
                setState(() {
                  fitnessProvider.selectedValueForBodyType =
                      value! ? 'rehabilitation_and_recovery' : null;
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
                      if (fitnessProvider.currentStep > 0) {
                        setState(() {
                          fitnessProvider.currentStep--;
                        });
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.fitnessAndPhysicalActitvity5,
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
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.healthAndBiohackingScreen1,
                        arguments: fitnessProvider.currentStep + 1,
                      );
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

import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:nutri_care_mobile/core/widgets/radio_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../res/utils.dart';
import '../domain/lifestyle_provider.dart';

class LifestyleScreen3 extends StatefulWidget {
  const LifestyleScreen3({Key? key}) : super(key: key);

  @override
  _LifestyleScreen3State createState() => _LifestyleScreen3State();
}

class _LifestyleScreen3State extends State<LifestyleScreen3> {
  @override
  Widget build(BuildContext context) {
    final lifeStyleProvider = Provider.of<LifestyleAndHabitProvider>(context);
    lifeStyleProvider.initContext(context: context);
    lifeStyleProvider.currentStep = 1;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              'Lifestyle and Daily Habits',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            ProgressIndicatorWidget(
                currentStep: lifeStyleProvider.currentStep, totalSteps: 3),
            SizedBox(height: 50),
            Text(
              'What is your daily water intake?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RadioOptionTile(
              title: 'Less than 1 liter',
              isSelected: lifeStyleProvider.selectedWaterIntake == 'LT1',
              onChanged: (bool? value) {
                setState(() {
                  lifeStyleProvider.selectedWaterIntake = value! ? 'LT1' : null;
                });
              },
            ),
            RadioOptionTile(
              title: '1-2 liters',
              isSelected: lifeStyleProvider.selectedWaterIntake == '12L',
              onChanged: (bool? value) {
                setState(() {
                  lifeStyleProvider.selectedWaterIntake = value! ? '12L' : null;
                });
              },
            ),
            RadioOptionTile(
              title: '2-3 liters',
              isSelected: lifeStyleProvider.selectedWaterIntake == '23L',
              onChanged: (bool? value) {
                setState(() {
                  lifeStyleProvider.selectedWaterIntake = value! ? '23L' : null;
                });
              },
            ),
            RadioOptionTile(
              title: 'More than 3 liters',
              isSelected: lifeStyleProvider.selectedWaterIntake == 'MT3',
              onChanged: (bool? value) {
                setState(() {
                  lifeStyleProvider.selectedWaterIntake = value! ? 'MT3' : null;
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
                      if (lifeStyleProvider.currentStep > 1) {
                        setState(() {
                          lifeStyleProvider.currentStep--;
                        });
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.lifestyleScreen2,
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
                      if (lifeStyleProvider.selectedWaterIntake != null) {
                        // final provider = Provider.of<LifestyleAndHabitProvider>(context, listen: false);
                        // final profileId = await PreferenceUtils.getProfileId();
                        //
                        // await provider.saveLifestyleData(
                        //   energyLevel: 'MOD', // Use the energy level from previous screen
                        //   waterIntake: selectedWaterIntake!,
                        //   sleepQuality: 'GD', // Replace with actual user input
                        //   substanceConsumption: 'CAF', // Replace with actual user input
                        //   stressLevel: 'OFT', // Replace with actual user input
                        //   profileId: profileId ?? '', // Ensure profile ID is passed
                        // );
                        print(
                            "selectedWaterIntake-->${lifeStyleProvider.selectedWaterIntake}");
                        setState(() {
                          lifeStyleProvider.currentStep++;
                        });
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.lifestyleScreen5,
                          arguments: lifeStyleProvider.currentStep + 1,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Please select your daily water intake'),
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

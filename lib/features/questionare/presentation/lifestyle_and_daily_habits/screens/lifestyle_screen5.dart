
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';
import '../../../../../core/widgets/radio_widget.dart';
import '../domain/lifestyle_provider.dart';

class LifestyleScreen5 extends StatefulWidget {
  const LifestyleScreen5({Key? key}) : super(key: key);

  @override
  _LifestyleScreen5State createState() => _LifestyleScreen5State();
}

class _LifestyleScreen5State extends State<LifestyleScreen5> {


  @override
  Widget build(BuildContext context) {
    final lifeStyleProvider = Provider.of<LifestyleAndHabitProvider>(context);
    lifeStyleProvider.initContext(context: context);
    lifeStyleProvider.currentStep = 3;
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
              'Do you consume any of the following regularly?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RadioOptionTile(
              title: 'Alcohol',
              isSelected: lifeStyleProvider.selectedDrugsValues.contains('alcohol'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!lifeStyleProvider.selectedDrugsValues.contains('alcohol')) {
                      lifeStyleProvider.selectedDrugsValues.add('alcohol');
                    }
                  } else {
                    lifeStyleProvider.selectedDrugsValues.remove('alcohol');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Caffeine',
              isSelected: lifeStyleProvider.selectedDrugsValues.contains('caffeine'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!lifeStyleProvider.selectedDrugsValues.contains('caffeine')) {
                      lifeStyleProvider.selectedDrugsValues.add('caffeine');
                    }
                  } else {
                    lifeStyleProvider.selectedDrugsValues.remove('caffeine');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Nicotine',
              isSelected: lifeStyleProvider.selectedDrugsValues.contains('nicotine'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!lifeStyleProvider.selectedDrugsValues.contains('nicotine')) {
                      lifeStyleProvider.selectedDrugsValues.add('nicotine');
                    }
                  } else {
                    lifeStyleProvider.selectedDrugsValues.remove('nicotine');
                  }
                });
              },
            ),
            RadioOptionTile(
              title: 'Recreational Drugs',
              isSelected: lifeStyleProvider.selectedDrugsValues.contains('recreational_drugs'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (!lifeStyleProvider.selectedDrugsValues.contains('recreational_drugs')) {
                      lifeStyleProvider.selectedDrugsValues.add('recreational_drugs');
                    }
                  } else {
                    lifeStyleProvider.selectedDrugsValues.remove('recreational_drugs');
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
                      if (lifeStyleProvider.currentStep > 0) {
                        setState(() {
                          lifeStyleProvider.currentStep--;
                        });
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.lifestyleScreen3,
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
                      if (lifeStyleProvider.selectedDrugsValues.isNotEmpty) {
                        print("selectedDrugsValues--->${lifeStyleProvider.selectedDrugsValues}");

                        setState(() {
                          lifeStyleProvider.currentStep++;
                        });
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.dietNurtion1,
                          arguments: lifeStyleProvider.currentStep + 1,
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

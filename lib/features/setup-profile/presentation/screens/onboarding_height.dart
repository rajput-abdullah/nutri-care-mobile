import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/widgets/setup_profile_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/progress_indicator.dart';
import '../../../../res/strings.dart';
import '../../../../res/utils.dart';
import '../../domain/onboarding_provider.dart';

class OnboardingHeight extends StatefulWidget {
  const OnboardingHeight({super.key});

  @override
  _OnboardingHeightState createState() => _OnboardingHeightState();
}

class _OnboardingHeightState extends State<OnboardingHeight> {
  late FixedExtentScrollController _scrollController;
  final double itemWidth = 60.0;

  @override
  void initState() {
    super.initState();
    final onboardingProvider =
    Provider.of<OnboardingProvider>(context, listen: false);
    _scrollController = FixedExtentScrollController(
      initialItem: onboardingProvider.isFeet
          ? ((onboardingProvider.height - 3) * 12).round() // Adjust for feet range (3 to 8 ft)
          : (onboardingProvider.height - 100).round(), // Adjust for cm range (100 to 250 cm)
    );

    _scrollController.addListener(() {
      int value = _scrollController.selectedItem;
      setState(() {
        if (onboardingProvider.isFeet) {
          // Map the index to a height in feet (e.g., index 0 = 3 ft, index 60 = 8 ft)
          onboardingProvider.height = (value / 12) + 3; // Each index represents 1 inch
        } else {
          onboardingProvider.height = (value + 100).toDouble(); // Each index represents 1 cm
        }
      });
    });
  }

  String _formatHeight(double heightInFeet) {
    int feet = heightInFeet.floor();
    int inches = ((heightInFeet - feet) * 12).round();
    if (inches >= 12) {
      feet += 1;
      inches = 0;
    }
    return '$feet ft $inches in';
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = Provider.of<OnboardingProvider>(context);
    onboardingProvider.initContext(context);
    int step = onboardingProvider.currentStep+1;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Your Height',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  ProgressIndicatorWidget(
                    currentStep: step, totalSteps: 5,stepWidth: 59, ),
                  const SizedBox(height: 40),
                  const Text(
                    'What is your height?',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This Helps Us Tailor Your Personalized Plan',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 95, 132, 146),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 250,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 204, 248, 242),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Tab bar style for cm and ft
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppColors.greyColor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// ft
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            onboardingProvider.isFeet = true;
                                            _scrollController.jumpToItem(
                                                ((onboardingProvider.height - 3) *
                                                    12)
                                                    .round());
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: onboardingProvider.isFeet
                                                ? const Color.fromARGB(
                                                255, 204, 248, 242)
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'ft',
                                            style: TextStyle(
                                              color: onboardingProvider.isFeet
                                                  ? Colors.black
                                                  : Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      /// cm
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            onboardingProvider.isFeet = false;
                                            _scrollController.jumpToItem(
                                                (onboardingProvider.height - 100)
                                                    .round());
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: !onboardingProvider.isFeet
                                                ? const Color.fromARGB(
                                                255, 204, 248, 242)
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'cm',
                                            style: TextStyle(
                                              color: !onboardingProvider.isFeet
                                                  ? Colors.black
                                                  : Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                onboardingProvider.isFeet
                                    ? Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${_formatHeight(onboardingProvider.height).split(' ft ')[0]}',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Text(
                                      ' ft ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      _formatHeight(
                                          onboardingProvider.height)
                                          .split(' ft ')[1]
                                          .split(' in')[0],
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Text(
                                      ' in',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${onboardingProvider.height.toInt()} ',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Text(
                                      ' cm',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 200,
                              padding: const EdgeInsets.all(28),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ListWheelScrollView.useDelegate(
                                    controller: _scrollController,
                                    itemExtent: itemWidth,
                                    perspective: 0.01,
                                    diameterRatio: 1.5,
                                    physics: const FixedExtentScrollPhysics(),
                                    childDelegate: ListWheelChildBuilderDelegate(
                                      builder: (context, index) {
                                        final isSelected = index ==
                                            _scrollController.selectedItem;
                                        return Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              onboardingProvider.isFeet
                                                  ? '${(index / 12 + 3).toStringAsFixed(2)}'
                                                  : '${index + 100}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: isSelected
                                                    ? AppColors.primaryColor
                                                    : Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            Expanded(
                                              child: Container(
                                                height: 2,
                                                color: isSelected
                                                    ? AppColors.primaryColor
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      childCount: onboardingProvider.isFeet
                                          ? 60 // 3 ft to 8 ft (60 inches)
                                          : 150, // 100 cm to 250 cm
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height * 0.25,
                                    child: Container(
                                      width: 40,
                                      height: 2,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.onboardingGenderScreen,
                          arguments: onboardingProvider.currentStep - 1,
                        );
                      },
                      child: const Text(
                        'Previous',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.onboardingWeightScreen,
                          arguments: onboardingProvider.currentStep + 1,
                        );

                        // final String profileId =
                        //     PreferenceUtils.getString(Strings.profileId) ?? "";
                        // onboardingProvider
                        //     .updateHeight(profileId: profileId)
                        //     .then(
                        //       (value) {
                        //     if (value) {
                        //       Navigator.pushReplacementNamed(
                        //         context,
                        //         AppRoutes.onboardingWeightScreen,
                        //         arguments: onboardingProvider.currentStep + 1,
                        //       );
                        //     }
                        //   },
                        // );
                      },
                      child: const Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
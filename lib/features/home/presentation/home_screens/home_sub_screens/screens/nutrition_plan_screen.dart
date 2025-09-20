// import 'package:flutter/material.dart';
// import 'package:nutri_care_mobile/res/res_export.dart';
// import 'package:nutri_care_mobile/res/utils.dart';
// import 'package:nutri_care_mobile/core/constants/app_colors.dart';
// import 'package:nutri_care_mobile/core/routes/app_routes.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../profile/presentation/nutrition/domain/nutrition_provider.dart';
// import '../../../../../../res/common_widgets.dart';
//
// class NutritionPlanScreen extends StatefulWidget {
//   const NutritionPlanScreen({super.key});
//
//   @override
//   NutritionPlanScreenState createState() => NutritionPlanScreenState();
// }
//
// class NutritionPlanScreenState extends State<NutritionPlanScreen> {
//   DateTime selectedDate = DateTime.now();
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<NutritionProvider>(context, listen: false);
//       provider.initContext(context);
//       provider.callGetNutritionPlan();
//     });;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     initializeResources(context: context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(
//                 context, AppRoutes.profileScreen);
//           },
//           child: Padding(
//             padding: EdgeInsets.all(5),
//             child: ProfileAvatar(
//               networkImageUrl: PreferenceUtils.getString(Strings.profilePicture) ?? "",
//               assetImagePath: Assets.profileImage,
//               radius: 30.0,
//             ),
//           ),
//         ),
//         title: const Text(
//           'Nutrition',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 5,),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10, // or any dynamic count
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 8.0),
//                   child: Container(
//                     height: sizes!.height * 0.25,
//                     width: sizes!.width,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           spreadRadius: 3,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Container(
//                           height: sizes!.height * 0.035,
//                           width: sizes!.width * 0.15,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: CustomText(
//                             text: "Day 1",
//                             fontWeight: FontWeight.w500,
//                             fontSize: sizes?.fontSize14,
//                             alignment: Alignment.center,
//                             color: AppColors.blackTextColor,
//                             fontFamily: 'Inter Tight',
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         SizedBox(height: sizes!.height*0.14,
//                           child: ListView.builder(
//                               itemCount: 3, // or any dynamic count
//                               itemBuilder: (context, index) {
//                                 return Padding(padding: EdgeInsets.only(
//                                     bottom: 5
//                                 ),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: "• Breakfast: ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text:
//                                           "Oatmeal with banana slices and chia seeds + green tea",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),);
//                               }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// screens/nutrition_plan_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../profile/presentation/nutrition/domain/nutrition_provider.dart';
import '../../../../../../res/assets.dart';
import '../../../../../../res/common_widgets.dart';
import '../../../../../../res/res.dart';
import '../../../../../../res/strings.dart';
import '../../../../../../res/utils.dart';

class NutritionPlanScreen extends StatefulWidget {
  const NutritionPlanScreen({Key? key}) : super(key: key);

  @override
  State<NutritionPlanScreen> createState() => _NutritionPlanScreenState();
}

class _NutritionPlanScreenState extends State<NutritionPlanScreen> {
  bool _loadingProfile = true;
  bool _didInitResources = false;
  ValueNotifier<String> profileImage = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _loadingProfile = true;
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final img = PreferenceUtils.getString(Strings.profilePicture);
      if (!mounted) return;
      setState(() {
        profileImage.value = ((img != null && img.isNotEmpty) ? img : null)??"";
        _loadingProfile = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        profileImage.value = '';
        _loadingProfile = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInitResources) {
      initializeResources(context: context);
      _didInitResources = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                    context, AppRoutes.notificationScreen);
              },
              child: Icon(Icons.notifications, color: AppColors.greyTextColor,size: 34,)),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, AppRoutes.profileScreen);
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.grey.shade200,
              child: _loadingProfile
                  ? const SizedBox(
                width: 60,
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
                  : ClipOval(
                child: (profileImage.value != '')
                    ? ValueListenableBuilder<String>(
                    valueListenable: profileImage,
                    builder: (context, value, child) {
                        return Image.network(
                                          profileImage.value,
                                          key: ValueKey(profileImage.value), // <- forces widget to update when URL changes

                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2),
                          ),
                        );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.profileImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        );
                                          },
                                        );
                      }
                    )
                    : Image.asset(
                  Assets.profileImage,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: CustomText(
          text: "Nutrition Plan Screen",
          fontWeight: FontWeight.normal,
          fontSize: sizes?.fontSize24,
          alignment: Alignment.center,
          color: AppColors.blackTextColor,
          fontFamily: 'Inter Tight',
        ),
        centerTitle: false,
      ),
      body: Consumer<NutritionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Skeletonizer(
              child: ListView.builder(
                itemCount: 10, // or any dynamic count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      height: sizes!.height * 0.25,
                      width: sizes!.width,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: sizes!.height * 0.035,
                            width: sizes!.width * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CustomText(
                              text: "Day 1",
                              fontWeight: FontWeight.w500,
                              fontSize: sizes?.fontSize14,
                              alignment: Alignment.center,
                              color: AppColors.blackTextColor,
                              fontFamily: 'Inter Tight',
                            ),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(height: sizes!.height*0.14,
                            child: ListView.builder(
                                itemCount: 3, // or any dynamic count
                                itemBuilder: (context, index) {
                                  return Padding(padding: EdgeInsets.only(
                                      bottom: 5
                                  ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "• Breakfast: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            "Oatmeal with banana slices and chia seeds + green tea",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),);
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (provider.error != null) {
            return Center(child: Text(provider.error!));
          } else if (provider.plans.isEmpty) {
            return const Center(child: Text("No data available"));
          } else {
            return ListView.builder(
              itemCount: provider.plans.length,
              itemBuilder: (context, index) {
                final plan = provider.plans[index];
                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: plan.day,
                          fontWeight: FontWeight.bold,
                          fontSize: sizes?.fontSize20,
                          alignment: Alignment.centerLeft,
                          color: AppColors.blackTextColor,
                          fontFamily: 'Inter Tight',
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                               TextSpan(
                                text: "Breakfast: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',// bold for label
                                ),
                              ),
                              TextSpan(
                                text: plan.breakfast, // normal text for value
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',// bold for label
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Lunch: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',
                                ),
                              ),
                              TextSpan(
                                text: plan.lunch,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4), // spacing between items

                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Snack: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',
                                ),
                              ),
                              TextSpan(
                                text: plan.snack,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),

                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Dinner: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',
                                ),
                              ),
                              TextSpan(
                                text: plan.dinner,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: sizes?.fontSize16,
                                  color: AppColors.blackTextColor,
                                  fontFamily: 'Inter Tight',
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:nutri_care_mobile/core/routes/app_routes.dart';
// import 'package:nutri_care_mobile/core/widgets/custom_button_widget.dart';
// import 'package:nutri_care_mobile/profile/presentation/subscription/widgets/features_lists.dart';
// import 'package:nutri_care_mobile/res/assets.dart';
// import 'package:nutri_care_mobile/core/constants/app_colors.dart';
// import 'package:provider/provider.dart';
// import '../../../../models/get_plans_subscription_response_model.dart';
// import '../domain/subscription_provider.dart';
//
// class SubscriptionScreen1 extends StatefulWidget {
//   const SubscriptionScreen1({Key? key}) : super(key: key);
//
//   @override
//   _SubscriptionScreen1State createState() => _SubscriptionScreen1State();
// }
//
// class _SubscriptionScreen1State extends State<SubscriptionScreen1> {
//   int selectedOption = 0;
//   List<Plans> subscriptionPlans = []; // List to hold subscription plans
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPlans(); // Fetch subscription plans when the widget is initialized
//   }
//
//   Future<void> fetchPlans() async {
//     await Provider.of<SubscriptionProvider>(context, listen: false).fetchSubscriptionPlans();
//     setState(() {
//       subscriptionPlans = Provider.of<SubscriptionProvider>(context, listen: false).getPlansSubscriptionResponseModel.data?.plans ?? [];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             Assets.subscriptionImage,
//             fit: BoxFit.cover,
//             height: double.infinity,
//             width: double.infinity,
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {},
//                         child: const Text(
//                           "Restore",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 14.0),
//                   const Text(
//                     "Nutri CareAI",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   const Text(
//                     "Biohack Your Health: Unlock Peak\nPerformance with AI",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   const SizedBox(height: 50.0),
//
//                   // Subscription Options
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: subscriptionPlans.isEmpty
//                         ? [const CircularProgressIndicator()]
//                         : subscriptionPlans.map((plan) {
//                       return Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedOption = plan.planCode == "BASIC" ? 1 : 2; // Adjust as needed
//                             });
//                           },
//                           child: Container(
//                             width: 190,
//                             height: 210,
//                             margin: const EdgeInsets.symmetric(horizontal: 8.0), // Add margin for spacing
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: selectedOption == (plan.planCode == "BASIC" ? 1 : 2) ? AppColors.subscriptionBorderColor : Colors.grey,
//                                 width: 2.0,
//                               ),
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             child: Stack(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                         decoration: BoxDecoration(
//                                           color: Colors.blue,
//                                           borderRadius: BorderRadius.circular(12),
//                                         ),
//                                         child: Text(
//                                           // plan.planName ??
//                                               "Pro",
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8.0),
//                                       Text(
//                                         "\$${plan.planPrice ?? 0}",
//                                         style: const TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 55.0),
//                                       const Text(
//                                         "Billed Monthly",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 if (selectedOption == (plan.planCode == "BASIC" ? 1 : 2))
//                                   Positioned(
//                                     top: -2.0,
//                                     right: -2.0,
//                                     child: Image.asset(
//                                       Assets.checkIcon,
//                                       height: 25,
//                                       width: 25,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//
//                   const SizedBox(height: 20.0),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: const Text(
//                       "Included Features",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           const FeatureList(),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     height: 50.0,
//                     child: CustomWidgetButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, AppRoutes.subscriptionScreen2);
//                       },
//                       label: "Subscribe",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/core/routes/app_routes.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button_widget.dart';
import 'package:nutri_care_mobile/profile/presentation/subscription/widgets/features_lists.dart';
import 'package:nutri_care_mobile/res/assets.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../models/get_plans_subscription_response_model.dart';
import '../domain/subscription_provider.dart';

class SubscriptionScreen1 extends StatefulWidget {
  const SubscriptionScreen1({Key? key}) : super(key: key);

  @override
  _SubscriptionScreen1State createState() => _SubscriptionScreen1State();
}

class _SubscriptionScreen1State extends State<SubscriptionScreen1> {
  String selectedPlanCode = ""; // Use plan code to track the selected plan
  List<Plans> subscriptionPlans = []; // List to hold subscription plans

  @override
  void initState() {
    super.initState();
    fetchPlans(); // Fetch subscription plans when the widget is initialized
  }

  Future<void> fetchPlans() async {
    await Provider.of<SubscriptionProvider>(context, listen: false).fetchSubscriptionPlans();
    setState(() {
      subscriptionPlans = Provider.of<SubscriptionProvider>(context, listen: false).getPlansSubscriptionResponseModel.data?.plans ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.subscriptionImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Restore",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14.0),
                  const Text(
                    "Nutri Care",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Biohack Your Health: Unlock Peak\nPerformance with AI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 50.0),

                  // Subscription Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: subscriptionPlans.isEmpty
                        ? [const CircularProgressIndicator()]
                        : subscriptionPlans.map((plan) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPlanCode = plan.planCode!; // Set the selected plan code
                            });
                          },
                          child: Container(
                            width: 190,
                            height: 210,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0), // Add margin for spacing
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedPlanCode == plan.planCode ? AppColors.subscriptionBorderColor : Colors.grey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          // plan.planName ??
                                              "Pro", // Use the actual plan name
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "\$${plan.planPrice}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 55.0),
                                      const Text(
                                        "Billed Monthly", // Adjust if necessary
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (selectedPlanCode == plan.planCode)
                                  Positioned(
                                    top: -2.0,
                                    right: -2.0,
                                    child: Image.asset(
                                      Assets.checkIcon,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Included Features",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const FeatureList(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50.0,
                    child: CustomWidgetButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.subscriptionScreen2);
                      },
                      label: "Subscribe",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
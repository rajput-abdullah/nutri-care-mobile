// import 'package:flutter/material.dart';
// import 'package:nutri_care_mobile/core/routes/app_routes.dart';
// import 'package:nutri_care_mobile/core/widgets/button_widget.dart';
// import '../../../../../res/assets.dart';
//
// class NutritionScreen3 extends StatefulWidget {
//   const NutritionScreen3({super.key});
//
//   @override
//   NutritionScreen3State createState() => NutritionScreen3State();
// }
//
// class NutritionScreen3State extends State<NutritionScreen3> {
//   final List<Map<String, dynamic>> items = [
//     {"name": "Cookies", "image": Assets.profileImage, "selected": false},
//     {"name": "Fruits", "image": Assets.profileImage, "selected": false},
//     {"name": "Fresh Broccoli", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//     {"name": "Milk", "image": Assets.profileImage, "selected": false},
//   ];
//
//   void toggleSelection(int index) {
//     setState(() {
//       items[index]['selected'] = !items[index]['selected'];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Grocery List',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Image.asset(
//                 Assets.scanLine,
//                 width: 24,
//                 height: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Expanded(
//             child: Container(
//               margin:
//                   const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(12.0),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 2)),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Recommended essential items for your plan",
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: items.length,
//                         itemBuilder: (context, index) {
//                           final item = items[index];
//                           return GestureDetector(
//                             onTap: () => toggleSelection(index),
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16.0),
//                               height: 60.0,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 4.0,
//                                     offset: Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     item['image'],
//                                     width: 32.0,
//                                     height: 32.0,
//                                     fit: BoxFit.cover,
//                                   ),
//                                   const SizedBox(width: 16.0),
//                                   Expanded(
//                                     child: Text(
//                                       item['name'],
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14.0,
//                                       ),
//                                     ),
//                                   ),
//                                   Icon(
//                                     item['selected']
//                                         ? Icons.check
//                                         : Icons.check_box_outline_blank,
//                                     color: item['selected']
//                                         ? Colors.green
//                                         : Colors.grey.shade400,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
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
import 'package:nutri_care_mobile/core/widgets/button_widget.dart';
import '../../../../../res/assets.dart';
import '../../../../core/constants/app_colors.dart';

class NutritionScreen3 extends StatefulWidget {
  const NutritionScreen3({super.key});

  @override
  NutritionScreen3State createState() => NutritionScreen3State();
}

class NutritionScreen3State extends State<NutritionScreen3> {
  final List<Map<String, dynamic>> items = [
    {"name": "Cookies", "image": Assets.profileImage, "selected": false},
    {"name": "Fruits", "image": Assets.profileImage, "selected": false},
    {"name": "Fresh Broccoli", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
    {"name": "Milk", "image": Assets.profileImage, "selected": false},
  ];

  void toggleSelection(int index) {
    setState(() {
      items[index]['selected'] = !items[index]['selected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Grocery List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                Assets.scanLine,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Container(
              margin:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recommended essential items for your plan",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () => toggleSelection(index),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    item['image'],
                                    width: 32.0,
                                    height: 32.0,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  _buildCheckmark(item['selected']),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckmark(bool isSelected) {
    return Container(
      width: 32.0, // Slightly larger to accommodate the outer background
      height: 32.0,
      decoration: BoxDecoration(
        color: isSelected
            ?  const Color.fromARGB(255, 200, 230, 201) // Light green background when selected
            : AppColors.greyLightColor, // Grey background when unselected
        borderRadius: BorderRadius.circular(8.0), // Rounded corners for the outer container
      ),
      child: Center(
        child: Container(
          width: 16.0, // Inner square size
          height: 16.0,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 56, 142, 60) // Darker green for the inner square when selected
                : Colors.transparent, // Transparent (no fill) when unselected
            border: Border.all(
              color: isSelected
                  ? const Color.fromARGB(255, 56, 142, 60) // Match the inner square color when selected
                  : Colors.grey.shade400, // Grey border for unselected
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0), // Slightly rounded corners for the inner square
          ),
          child: isSelected
              ? const Icon(
                          Icons.check,
                          color: Colors.white, // White checkmark when selected
                          size: 16.0, // Smaller size to fit inside the square
                        )
              : null, // No icon for unselected state
        ),
      ),
    );
  }
}
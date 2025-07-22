import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../res/assets.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: BottomNavigationBar(
            currentIndex: widget.currentIndex,
            onTap: widget.onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.sevenDaysNutritionIcon,
                  height: 24, // set size
                  width: 24,
                  color: AppColors.primaryColor, // optional, if your SVG supports it
                ),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.mentalHealthChatIcon,
                  height: 24, // set size
                  width: 24,
                  color: AppColors.primaryColor, // optional, if your SVG supports it
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.scanIcon,
                  height: 24, // set size
                  width: 24,
                  color: AppColors.primaryColor, // optional, if your SVG supports it
                ), // Placeholder for center scanner button
                label: 'Scanner',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

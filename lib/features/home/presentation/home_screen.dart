import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/features/home/domain/home_provider.dart';
import 'package:nutri_care_mobile/features/home/presentation/home_screens/home_sub_screens/screens/report_scanner_screen.dart';
import 'package:provider/provider.dart';
import '../../../profile/presentation/nutrition/domain/nutrition_provider.dart';
import '../home_widgets/custom_nav_bar.dart';
import 'home_screens/home_sub_screens/screens/mental_health_chat_screen.dart';
import 'home_screens/home_sub_screens/screens/nutrition_plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider homeProvider = HomeProvider();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    NutritionPlanScreen(),
    MentalHealthChatScreen(),
    ReportScannerScreen()
  ];

  void onItemTapped(int index) {
    if (index == 3) {

      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NutritionProvider>(context, listen: false).fetchNutritionPlan();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

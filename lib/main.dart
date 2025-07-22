import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/providers/multi_providers.dart';
import 'package:nutri_care_mobile/res/notifications.dart';
import 'package:nutri_care_mobile/res/res.dart';
import 'package:nutri_care_mobile/res/utils.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await PreferenceUtils.init();
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessagingService().configureFirebaseMessaging();
  } catch (e) {
    debugPrint('Error during initialization: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);
    return MultiProvider(
      providers: multiProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NutriCare',
        navigatorKey: navigatorKey,
        // initialRoute: AppRoutes.mentalHealthChatScreen,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/personal_info_screen.dart';
// import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
// More imports as we build more screens

class AppRoutes {
  // Route names
  static const String welcome = '/';
  static const String personalInfo = '/personal-info';
  static const String bodyGoal = '/body-goal';
  static const String problemAreas = '/problem-areas';
  static const String planSummary = '/plan-summary';
  static const String dashboard = '/dashboard';
  static const String nutrition = '/nutrition';
  static const String workouts = '/workouts';
  static const String progress = '/progress';
  static const String profile = '/profile';

  // Route map (we'll add more as we build)
  static Map<String, WidgetBuilder> get routes => {
    welcome: (context) => const WelcomeScreen(),
    personalInfo: (context) => const PersonalInfoScreen(),
    // dashboard: (context) => const DashboardScreen(),
    // More routes as we build
  };

  // Route generator for dynamic routes with arguments
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      
      case personalInfo:
        return MaterialPageRoute(builder: (context) => const PersonalInfoScreen());
      
      // Add more cases as needed
      
      default:
        return null;
    }
  }

  // Unknown route handler
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'shared/services/local_storage_service.dart';
import 'features/onboarding/presentation/screens/welcome_screen.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await LocalStorageService.init();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  
  runApp(const AfroFitWellnessApp());
}

class AfroFitWellnessApp extends StatelessWidget {
  const AfroFitWellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AfroFit Wellness',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Run initialization and minimal splash delay in parallel
    await Future.wait([
      _checkOnboardingStatus(),
      Future.delayed(const Duration(milliseconds: 1500)),
    ]);
  }

  Future<void> _checkOnboardingStatus() async {
    try {
      // ✅ FIXED: Use the correct method from LocalStorageService
      final isOnboarded = await LocalStorageService.isOnboardingComplete();
      
      if (!mounted) return;
      
      // Navigate to appropriate screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isOnboarded 
              ? const DashboardScreen()
              : const WelcomeScreen(),
        ),
      );
    } catch (e) {
      // If error checking status, go to onboarding to be safe
      debugPrint('Error checking onboarding status: $e');
      
      if (!mounted) return;
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo with shadow
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.fitness_center,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            
            // App Name
            const Text(
              'AfroFit Wellness',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            
            // Tagline
            Text(
              'Fitness Made for Africa',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 40),
            
            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withOpacity(0.8),
              ),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
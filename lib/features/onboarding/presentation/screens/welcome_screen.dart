import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../shared/widgets/primary_button.dart';
import 'personal_info_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // App Logo/Icon
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Title
              Text(
                StringConstants.welcomeTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 132, 226, 153),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                StringConstants.welcomeSubtitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorPalette.textSecondary,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Description
              Text(
                StringConstants.welcomeDescription,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorPalette.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // Features List
              _buildFeatureItem(
                icon: Icons.restaurant,
                title: 'African Food Database',
                description: 'Track meals with foods you actually eat',
              ),
              
              const SizedBox(height: 16),
              
              _buildFeatureItem(
                icon: Icons.fitness_center,
                title: 'Personalized Workouts',
                description: 'Exercises tailored to your body goals',
              ),
              
              const SizedBox(height: 16),
              
              _buildFeatureItem(
                icon: Icons.trending_up,
                title: 'Real Progress Tracking',
                description: 'See your transformation over time',
              ),
              
              const SizedBox(height: 48),
              
              // Get Started Button
              PrimaryButton(
                text: StringConstants.buttonGetStarted,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInfoScreen(),
                    ),
                  );
                },
                icon: Icons.arrow_forward,
              ),
              
              const SizedBox(height: 16),
              
              // Skip for now text
              Center(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete onboarding to continue'),
                      ),
                    );
                  },
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(
                      color: ColorPalette.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: ColorPalette.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: ColorPalette.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 164, 236, 179),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorPalette.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
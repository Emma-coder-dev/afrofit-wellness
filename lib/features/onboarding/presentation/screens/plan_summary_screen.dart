import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';

class PlanSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const PlanSummaryScreen({
    super.key,
    required this.userData,
  });

  void _handleStartJourney(BuildContext context) async {
    try {
      // Calculate daily goals
      final dailyGoals = _calculateDailyGoals();
      
      // Add daily goals to user data
      final completeUserData = {
        ...userData,
        'id': const Uuid().v4(),
        'dailyGoals': dailyGoals,
        'createdAt': DateTime.now().toIso8601String(),
      };
      
      // Save user data to Hive
      await LocalStorageService.saveUserData(completeUserData);
      
      // Mark onboarding as complete
      await LocalStorageService.markOnboardingComplete();
      
      // Create initial progress entry
      final todayKey = LocalStorageService.getTodayKey();
      await LocalStorageService.saveDailyLog(todayKey, {
        'date': DateTime.now().toIso8601String(),
        'caloriesConsumed': 0,
        'proteinConsumed': 0,
        'waterConsumed': 0,
        'workoutCompleted': false,
        'workoutDuration': 0,
        'caloriesBurned': 0,
        'meals': [],
      });
      
      // Navigate to Dashboard (remove all previous routes)
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
          (route) => false, // Remove all previous routes
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving data: $e'),
            backgroundColor: ColorPalette.error,
          ),
        );
      }
    }
  }

  Map<String, dynamic> _calculateDailyGoals() {
    final age = userData['age'] as int;
    final currentWeight = userData['currentWeight'] as double;
    final height = userData['height'] as double;
    final gender = userData['gender'] as String;
    final activityLevel = userData['activityLevel'] as String;
    
    // Calculate BMR (Basal Metabolic Rate)
    double bmr;
    if (gender == 'male') {
      bmr = 88.362 + (13.397 * currentWeight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * currentWeight) + (3.098 * height) - (4.330 * age);
    }
    
    // Get activity multiplier
    final multiplier = AppConstants.activityMultipliers[activityLevel] ?? 1.2;
    
    // Calculate TDEE (Total Daily Energy Expenditure)
    final tdee = bmr * multiplier;
    
    // Create 500 calorie deficit for weight loss (1kg per week = 7,700 calories)
    final dailyCalories = (tdee - 500).round();
    
    // Calculate protein goal (2g per kg for weight loss)
    final protein = (currentWeight * 2).round();
    
    // Water goal (35ml per kg of body weight)
    final water = (currentWeight * 35).round();
    
    return {
      'calories': dailyCalories,
      'protein': protein,
      'carbs': ((dailyCalories * 0.4) / 4).round(), // 40% of calories from carbs
      'fats': ((dailyCalories * 0.3) / 9).round(),  // 30% of calories from fats
      'water': water,
      'sleep': 8, // 8 hours
      'steps': 8000, // 8,000 steps per day
    };
  }

  double _calculateBMI() {
    final weight = userData['currentWeight'] as double;
    final height = userData['height'] as double;
    return weight / ((height / 100) * (height / 100));
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  int _getEstimatedWeeks() {
    final currentWeight = userData['currentWeight'] as double;
    final targetWeight = userData['targetWeight'] as double;
    final weightToLose = currentWeight - targetWeight;
    
    // Healthy weight loss: 0.5-1kg per week (using 0.75kg average)
    return (weightToLose / 0.75).ceil();
  }

  String _getBodyShapeName(String shape) {
    final bodyShape = AppConstants.bodyShapeOptions.firstWhere(
      (s) => s['id'] == shape,
      orElse: () => {'name': 'Your Goal'},
    );
    return bodyShape['name'] as String;
  }

  @override
  Widget build(BuildContext context) {
    final dailyGoals = _calculateDailyGoals();
    final bmi = _calculateBMI();
    final bmiCategory = _getBMICategory(bmi);
    final estimatedWeeks = _getEstimatedWeeks();
    final bodyShapeName = _getBodyShapeName(userData['desiredBodyShape'] as String);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Your Personalized Plan',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Message
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorPalette.success.withOpacity(0.1),
                    ColorPalette.primary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ColorPalette.success.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: ColorPalette.success,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your Plan is Ready! 🎉',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.success,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We\'ve created a personalized fitness plan just for you',
                    style: TextStyle(
                      color: ColorPalette.textSecondary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Your Stats
            Text(
              'Your Stats',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _StatRow(
                    label: 'Current Weight',
                    value: '${userData['currentWeight']} kg',
                    icon: Icons.monitor_weight_outlined,
                  ),
                  const Divider(height: 24),
                  _StatRow(
                    label: 'Target Weight',
                    value: '${userData['targetWeight']} kg',
                    icon: Icons.flag_outlined,
                  ),
                  const Divider(height: 24),
                  _StatRow(
                    label: 'BMI',
                    value: '${bmi.toStringAsFixed(1)} ($bmiCategory)',
                    icon: Icons.assessment_outlined,
                  ),
                  const Divider(height: 24),
                  _StatRow(
                    label: 'Height',
                    value: '${userData['height']} cm',
                    icon: Icons.straighten_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Daily Goals
            Text(
              'Your Daily Goals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _GoalCard(
                  icon: Icons.local_fire_department,
                  label: 'Calories',
                  value: '${dailyGoals['calories']}',
                  unit: 'kcal/day',
                  color: Colors.orange,
                ),
                _GoalCard(
                  icon: Icons.fitness_center,
                  label: 'Protein',
                  value: '${dailyGoals['protein']}',
                  unit: 'g/day',
                  color: ColorPalette.secondary,
                ),
                _GoalCard(
                  icon: Icons.water_drop,
                  label: 'Water',
                  value: '${dailyGoals['water']}',
                  unit: 'ml/day',
                  color: Colors.blue,
                ),
                _GoalCard(
                  icon: Icons.bedtime,
                  label: 'Sleep',
                  value: '${dailyGoals['sleep']}',
                  unit: 'hours',
                  color: ColorPalette.accent,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Timeline & Body Goal
            Text(
              'Your Journey',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorPalette.primary.withOpacity(0.1),
                    ColorPalette.accent.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ColorPalette.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorPalette.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.calendar_today,
                          color: ColorPalette.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estimated Timeline',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: ColorPalette.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$estimatedWeeks weeks',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorPalette.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorPalette.accent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          color: ColorPalette.accent,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Body Goal',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: ColorPalette.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bodyShapeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorPalette.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Start Button
            PrimaryButton(
              text: 'Start My Journey',
              onPressed: () => _handleStartJourney(context),
              icon: Icons.rocket_launch,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorPalette.primary,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorPalette.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ColorPalette.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _GoalCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: color,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
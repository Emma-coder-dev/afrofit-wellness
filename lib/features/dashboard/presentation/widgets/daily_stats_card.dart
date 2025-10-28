import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';

class DailyStatsCard extends StatelessWidget {
  final int caloriesConsumed;
  final int caloriesGoal;
  final int caloriesBurned;
  final int waterConsumed;
  final int waterGoal;
  final bool workoutCompleted;

  const DailyStatsCard({
    super.key,
    required this.caloriesConsumed,
    required this.caloriesGoal,
    required this.caloriesBurned,
    required this.waterConsumed,
    required this.waterGoal,
    required this.workoutCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final netCalories = caloriesConsumed - caloriesBurned;
    final remainingCalories = caloriesGoal - netCalories;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.primaryLight.withOpacity(0.1),
            ColorPalette.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorPalette.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorPalette.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.today_outlined,
                  color: ColorPalette.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Today\'s Summary',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Calories Section
          _buildStatRow(
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            label: 'Calories',
            value: '$netCalories',
            goal: '$caloriesGoal',
            unit: 'kcal',
            progress: netCalories / caloriesGoal,
            subtitle: caloriesBurned > 0 
                ? 'Burned $caloriesBurned kcal' 
                : null,
          ),
          
          const Divider(height: 24),
          
          // Water Section
          _buildStatRow(
            icon: Icons.water_drop,
            iconColor: Colors.blue,
            label: 'Water',
            value: '$waterConsumed',
            goal: '$waterGoal',
            unit: 'ml',
            progress: waterConsumed / waterGoal,
          ),
          
          const Divider(height: 24),
          
          // Workout Section
          _buildWorkoutRow(workoutCompleted),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String goal,
    required String unit,
    required double progress,
    String? subtitle,
  }) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final remaining = int.parse(goal) - int.parse(value);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ColorPalette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorPalette.textPrimary,
                        ),
                      ),
                      Text(
                        ' / $goal $unit',
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: iconColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  remaining > 0 ? '$remaining' : 'Goal!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: remaining > 0 
                        ? ColorPalette.textPrimary 
                        : ColorPalette.success,
                  ),
                ),
                if (remaining > 0)
                  Text(
                    'left',
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorPalette.textSecondary,
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: clampedProgress,
            backgroundColor: iconColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(iconColor),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutRow(bool completed) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: completed 
                ? ColorPalette.success.withOpacity(0.1)
                : ColorPalette.textSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            completed ? Icons.check_circle : Icons.fitness_center,
            color: completed ? ColorPalette.success : ColorPalette.textSecondary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Workout',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: ColorPalette.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                completed ? 'Completed! 🎉' : 'Not started yet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: completed 
                      ? ColorPalette.success 
                      : ColorPalette.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Icon(
          completed ? Icons.check_circle : Icons.circle_outlined,
          color: completed ? ColorPalette.success : ColorPalette.textSecondary,
          size: 32,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../data/models/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final bool isSelected;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    this.isSelected = false,
  });

  Color _getDifficultyColor() {
    switch (exercise.difficulty) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getCategoryEmoji() {
    switch (exercise.category) {
      case 'warmup':
        return '🔥';
      case 'core':
        return '💪';
      case 'upper_body':
        return '🏋️';
      case 'lower_body':
        return '🦵';
      case 'cardio':
        return '❤️';
      case 'cooldown':
        return '🧘';
      default:
        return '💪';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? ColorPalette.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Exercise Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getCategoryEmoji(),
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 16),

              // Exercise Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercise.targetAreas.join(', '),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.timer,
                          label: exercise.duration != null
                              ? '${exercise.duration}s'
                              : '${exercise.reps} reps',
                          color: ColorPalette.primary,
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.local_fire_department,
                          label: '${exercise.caloriesPerMinute.toInt()} cal/min',
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Difficulty Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getDifficultyColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  exercise.difficulty.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getDifficultyColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
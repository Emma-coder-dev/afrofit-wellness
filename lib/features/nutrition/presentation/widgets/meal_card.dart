import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';

class MealCard extends StatelessWidget {
  final Map<String, dynamic> meal;
  final VoidCallback onDelete;

  const MealCard({
    super.key,
    required this.meal,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final foodName = meal['foodName'] as String;
    final servings = meal['servings'] as double;
    final calories = meal['calories'] as int;
    final protein = meal['protein'] as int;
    final portionSize = meal['portionSize'] as String?;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Food icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorPalette.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.restaurant,
              color: ColorPalette.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Food details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${servings.toStringAsFixed(1)}x $portionSize',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _NutrientChip(
                      icon: Icons.local_fire_department,
                      label: '$calories kcal',
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    _NutrientChip(
                      icon: Icons.fitness_center,
                      label: '${protein}g protein',
                      color: ColorPalette.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: ColorPalette.error,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Meal'),
                  content: const Text('Are you sure you want to delete this meal?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: ColorPalette.error,
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NutrientChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _NutrientChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
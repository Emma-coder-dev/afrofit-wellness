import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/truth_facts.dart';

class MotivationalCard extends StatelessWidget {
  final double currentWeight;
  final double targetWeight;
  final String bodyShape;

  const MotivationalCard({
    super.key,
    required this.currentWeight,
    required this.targetWeight,
    required this.bodyShape,
  });

  @override
  Widget build(BuildContext context) {
    // Get a random truth fact
    final facts = TruthFacts.mythBusters;
    final randomFact = facts[(DateTime.now().day) % facts.length];

    final weightToGo = currentWeight - targetWeight;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.accent.withValues(alpha: 0.1),
            ColorPalette.warning.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorPalette.accent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: ColorPalette.warning,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Truth Fact of the Day',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Myth section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.red.shade200,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    randomFact['myth']!.replaceAll('❌ ', ''),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Truth section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.green.shade200,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    randomFact['truth']!.replaceAll('✅ ', ''),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (weightToGo > 0) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ProgressStat(
                  icon: Icons.flag_outlined,
                  label: 'Goal',
                  value: '${weightToGo.toStringAsFixed(1)} kg',
                  color: ColorPalette.primary,
                ),
                _ProgressStat(
                  icon: Icons.trending_down,
                  label: 'Per Week',
                  value: '0.5-1 kg',
                  color: ColorPalette.success,
                ),
                _ProgressStat(
                  icon: Icons.calendar_today_outlined,
                  label: 'Est. Time',
                  value: '${(weightToGo / 0.75).ceil()} weeks',
                  color: ColorPalette.accent,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgressStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ProgressStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: ColorPalette.textSecondary,
          ),
        ),
      ],
    );
  }
}
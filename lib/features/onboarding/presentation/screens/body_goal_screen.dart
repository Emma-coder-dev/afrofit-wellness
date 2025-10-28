import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/selection_card.dart';
import 'problem_areas_screen.dart';

class BodyGoalScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const BodyGoalScreen({
    super.key,
    required this.userData,
  });

  @override
  State<BodyGoalScreen> createState() => _BodyGoalScreenState();
}

class _BodyGoalScreenState extends State<BodyGoalScreen> {
  String? _selectedBodyShape;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Body Goal',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Header
                Text(
                  StringConstants.bodyGoalTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  StringConstants.bodyGoalSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorPalette.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Body Shape Options Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: AppConstants.bodyShapeOptions.length,
                  itemBuilder: (context, index) {
                    final bodyShape = AppConstants.bodyShapeOptions[index];
                    return SelectionCard(
                      emoji: bodyShape['emoji'],
                      title: bodyShape['name'],
                      subtitle: bodyShape['timeline'],
                      isSelected: _selectedBodyShape == bodyShape['id'],
                      onTap: () {
                        setState(() {
                          _selectedBodyShape = bodyShape['id'];
                        });
                      },
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Selected Goal Info
                if (_selectedBodyShape != null) ...[
                  _buildSelectedGoalInfo(),
                ],
              ],
            ),
          ),
          
          // Bottom Button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: PrimaryButton(
                text: StringConstants.buttonContinue,
                onPressed: _selectedBodyShape != null ? _handleContinue : () {},
                isDisabled: _selectedBodyShape == null,
                icon: Icons.arrow_forward,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedGoalInfo() {
    final selectedGoal = AppConstants.bodyShapeOptions.firstWhere(
      (shape) => shape['id'] == _selectedBodyShape,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorPalette.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                selectedGoal['emoji'],
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  selectedGoal['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          _buildInfoRow(
            icon: Icons.schedule,
            label: 'Timeline',
            value: selectedGoal['timeline'],
          ),
          
          const SizedBox(height: 8),
          
          _buildInfoRow(
            icon: Icons.fitness_center,
            label: 'Focus Areas',
            value: (selectedGoal['focusAreas'] as List).join(', '),
          ),
          
          const SizedBox(height: 12),
          
          // Truth Fact
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorPalette.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: ColorPalette.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedGoal['truthFact'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: ColorPalette.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: ColorPalette.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                color: ColorPalette.textPrimary,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: ColorPalette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleContinue() {
    if (_selectedBodyShape != null) {
      // Combine previous data with new selection
      final completeData = {
        ...widget.userData,
        'desiredBodyShape': _selectedBodyShape,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProblemAreasScreen(
            userData: completeData,
          ),
        ),
      );
    }
  }
}
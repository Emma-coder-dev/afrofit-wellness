import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../../../../shared/widgets/selection_card.dart';
import 'plan_summary_screen.dart';

class ProblemAreasScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProblemAreasScreen({
    super.key,
    required this.userData,
  });

  @override
  State<ProblemAreasScreen> createState() => _ProblemAreasScreenState();
}

class _ProblemAreasScreenState extends State<ProblemAreasScreen> {
  final List<String> _selectedProblemAreas = [];

  // Group problem areas by category
  Map<String, List<Map<String, String>>> get _groupedProblemAreas {
    final Map<String, List<Map<String, String>>> grouped = {
      'upper_body': [],
      'core': [],
      'lower_body': [],
    };

    for (var area in AppConstants.problemAreas) {
      final category = area['category']!;
      grouped[category]?.add(area);
    }

    return grouped;
  }

  String _getCategoryTitle(String category) {
    switch (category) {
      case 'upper_body':
        return 'Upper Body';
      case 'core':
        return 'Core/Midsection';
      case 'lower_body':
        return 'Lower Body';
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Problem Areas',
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
                  StringConstants.problemAreasTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  StringConstants.problemAreasSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorPalette.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Truth Fact
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorPalette.accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: ColorPalette.secondary,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Important Truth:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'You cannot spot-reduce fat, but you CAN tone muscles underneath. We\'ll include exercises that target these areas.',
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorPalette.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Problem Areas by Category
                ..._groupedProblemAreas.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getCategoryTitle(entry.key),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Problem area checkboxes
                      ...entry.value.map((area) {
                        final areaId = area['id']!;
                        final isSelected = _selectedProblemAreas.contains(areaId);
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CheckboxSelectionCard(
                            title: area['name']!,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedProblemAreas.remove(areaId);
                                } else {
                                  _selectedProblemAreas.add(areaId);
                                }
                              });
                            },
                          ),
                        );
                      }).toList(),
                      
                      const SizedBox(height: 24),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Bottom Buttons
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Selected count
                  if (_selectedProblemAreas.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        '${_selectedProblemAreas.length} area${_selectedProblemAreas.length > 1 ? 's' : ''} selected',
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorPalette.textSecondary,
                        ),
                      ),
                    ),
                  
                  PrimaryButton(
                    text: StringConstants.buttonContinue,
                    onPressed: _handleContinue,
                    icon: Icons.arrow_forward,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  SecondaryButton(
                    text: StringConstants.buttonSkip,
                    onPressed: _handleSkip,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    // Combine all data
    final completeData = {
      ...widget.userData,
      'problemAreas': _selectedProblemAreas,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanSummaryScreen(
          userData: completeData,
        ),
      ),
    );
  }

  void _handleSkip() {
    // Continue with empty problem areas
    final completeData = {
      ...widget.userData,
      'problemAreas': <String>[],
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanSummaryScreen(
          userData: completeData,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../../data/models/exercise_model.dart';
import '../../data/datasources/exercise_data.dart';
import '../widgets/exercise_card.dart';
import 'exercise_detail_screen.dart';
import 'active_workout_screen.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  List<ExerciseModel> allExercises = [];
  List<ExerciseModel> recommendedExercises = [];
  List<ExerciseModel> selectedExercises = [];
  String selectedCategory = 'all';
  bool isLoading = true;

  final List<Map<String, dynamic>> categories = [
    {'id': 'all', 'name': 'All', 'icon': Icons.grid_view},
    {'id': 'warmup', 'name': 'Warm-up', 'icon': Icons.local_fire_department},
    {'id': 'core', 'name': 'Core', 'icon': Icons.accessibility_new},
    {'id': 'upper_body', 'name': 'Upper', 'icon': Icons.fitness_center},
    {'id': 'lower_body', 'name': 'Lower', 'icon': Icons.directions_run},
    {'id': 'cardio', 'name': 'Cardio', 'icon': Icons.favorite},
    {'id': 'cooldown', 'name': 'Cool-down', 'icon': Icons.self_improvement},
  ];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    setState(() => isLoading = true);

    try {
      // Get user data for personalized recommendations
      final userData = await LocalStorageService.getUserData();
      
      // Load all exercises
      allExercises = ExerciseData.allExercises;

      // Get personalized workout plan
      if (userData != null) {
        final bodyShape = userData['desiredBodyShape'] as String;
        final problemAreas = (userData['problemAreas'] as List<dynamic>).cast<String>();
        
        recommendedExercises = ExerciseData.getWorkoutPlan(bodyShape, problemAreas);
      } else {
        recommendedExercises = allExercises.take(10).toList();
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading exercises: $e')),
        );
      }
    }
  }

  List<ExerciseModel> _getFilteredExercises() {
    if (selectedCategory == 'all') {
      return allExercises;
    }
    return allExercises.where((ex) => ex.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final filteredExercises = _getFilteredExercises();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Workouts',
        showBackButton: true,
        actions: [
          if (selectedExercises.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${selectedExercises.length} selected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category['icon'] as IconData,
                          size: 16,
                          color: isSelected ? Colors.white : ColorPalette.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(category['name'] as String),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category['id'] as String;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: ColorPalette.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : ColorPalette.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),

          // Personalized Workout Banner
          if (selectedCategory == 'all' && recommendedExercises.isNotEmpty)
            _buildPersonalizedBanner(),

          // Exercise List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
                final isSelected = selectedExercises.contains(exercise);
                final isRecommended = recommendedExercises.contains(exercise);

                return Column(
                  children: [
                    if (isRecommended && index == 0) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: ColorPalette.warning, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Recommended for You',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    ExerciseCard(
                      exercise: exercise,
                      isSelected: isSelected,
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailScreen(exercise: exercise),
                          ),
                        );

                        if (result == true) {
                          setState(() {
                            if (selectedExercises.contains(exercise)) {
                              selectedExercises.remove(exercise);
                            } else {
                              selectedExercises.add(exercise);
                            }
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: selectedExercises.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveWorkoutScreen(
                      exercises: selectedExercises,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
              backgroundColor: ColorPalette.primary,
            )
          : FloatingActionButton.extended(
              onPressed: () {
                // Quick start with recommended exercises
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveWorkoutScreen(
                      exercises: recommendedExercises.take(8).toList(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.flash_on),
              label: const Text('Quick Start'),
              backgroundColor: ColorPalette.secondary,
            ),
    );
  }

  Widget _buildPersonalizedBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.primary.withValues(alpha: 0.1),
            ColorPalette.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorPalette.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorPalette.warning.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: ColorPalette.warning,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personalized Plan Ready!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'We\'ve selected exercises based on your goals',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedExercises = recommendedExercises.take(8).toList();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added recommended exercises! Tap Start Workout'),
                  backgroundColor: ColorPalette.success,
                ),
              );
            },
            child: const Text('Use Plan'),
          ),
        ],
      ),
    );
  }
}
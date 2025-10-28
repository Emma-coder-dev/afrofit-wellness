import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../../data/models/food_model.dart';
import 'search_food_screen.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  FoodModel? selectedFood;
  double servings = 1.0;
  String selectedMealType = 'breakfast';
  
  final List<Map<String, dynamic>> mealTypes = [
    {'id': 'breakfast', 'name': 'Breakfast', 'icon': Icons.free_breakfast},
    {'id': 'lunch', 'name': 'Lunch', 'icon': Icons.lunch_dining},
    {'id': 'dinner', 'name': 'Dinner', 'icon': Icons.dinner_dining},
    {'id': 'snack', 'name': 'Snack', 'icon': Icons.fastfood},
  ];

  Future<void> _saveMeal() async {
    if (selectedFood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a food')),
      );
      return;
    }

    try {
      // Calculate totals for this meal
      final totalCalories = (selectedFood!.calories * servings).round();
      final totalProtein = (selectedFood!.protein * servings).round();
      final totalCarbs = (selectedFood!.carbs * servings).round();
      final totalFats = (selectedFood!.fats * servings).round();

      // Create meal object
      final meal = {
        'id': const Uuid().v4(),
        'foodId': selectedFood!.id,
        'foodName': selectedFood!.name,
        'servings': servings,
        'portionSize': selectedFood!.portionSize,
        'calories': totalCalories,
        'protein': totalProtein,
        'carbs': totalCarbs,
        'fats': totalFats,
        'mealType': selectedMealType,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Get today's log
      final todayKey = LocalStorageService.getTodayKey();
      var dailyLog = await LocalStorageService.getDailyLog(todayKey);

      if (dailyLog == null) {
        // Create new log
        dailyLog = {
          'date': DateTime.now().toIso8601String(),
          'caloriesConsumed': 0,
          'proteinConsumed': 0,
          'waterConsumed': 0,
          'workoutCompleted': false,
          'workoutDuration': 0,
          'caloriesBurned': 0,
          'meals': [],
        };
      }

      // Add meal to log
      final meals = List<Map<String, dynamic>>.from(dailyLog['meals'] ?? []);
      meals.add(meal);

      // Update totals
      final newCalories = (dailyLog['caloriesConsumed'] as int? ?? 0) + totalCalories;
      final newProtein = (dailyLog['proteinConsumed'] as int? ?? 0) + totalProtein;

      // Update log
      dailyLog['meals'] = meals;
      dailyLog['caloriesConsumed'] = newCalories;
      dailyLog['proteinConsumed'] = newProtein;

      // Save to storage
      await LocalStorageService.saveDailyLog(todayKey, dailyLog);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Meal logged successfully! 🎉'),
            backgroundColor: ColorPalette.success,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving meal: $e'),
            backgroundColor: ColorPalette.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Add Meal',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Food',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            
            if (selectedFood == null)
              _buildSearchButton()
            else
              _buildSelectedFood(),
            
            const SizedBox(height: 24),

            if (selectedFood != null) ...[
              Text(
                'Servings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildServingsSelector(),
              const SizedBox(height: 24),

              _buildNutritionSummary(),
              const SizedBox(height: 24),
            ],

            Text(
              'Meal Type',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildMealTypeSelector(),
            const SizedBox(height: 32),

            if (selectedFood != null)
              PrimaryButton(
                text: 'Log Meal',
                onPressed: _saveMeal,
                icon: Icons.check,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push<FoodModel>(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchFoodScreen(),
          ),
        );

        if (result != null) {
          setState(() {
            selectedFood = result;
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorPalette.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorPalette.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.search,
                color: ColorPalette.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search African Foods',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ColorPalette.primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap to browse our food database',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorPalette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorPalette.primary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFood() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorPalette.success.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorPalette.success.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check_circle,
              color: ColorPalette.success,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedFood!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedFood!.portionSize,
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorPalette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            color: ColorPalette.primary,
            onPressed: () async {
              final result = await Navigator.push<FoodModel>(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchFoodScreen(),
                ),
              );

              if (result != null) {
                setState(() {
                  selectedFood = result;
                  servings = 1.0;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServingsSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Number of servings:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                servings.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: ColorPalette.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _ServingButton(
                icon: Icons.remove,
                onPressed: () {
                  if (servings > 0.5) {
                    setState(() => servings -= 0.5);
                  }
                },
              ),
              Expanded(
                child: Slider(
                  value: servings,
                  min: 0.5,
                  max: 5.0,
                  divisions: 9,
                  activeColor: ColorPalette.primary,
                  onChanged: (value) {
                    setState(() => servings = value);
                  },
                ),
              ),
              _ServingButton(
                icon: Icons.add,
                onPressed: () {
                  if (servings < 5.0) {
                    setState(() => servings += 0.5);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary() {
    final totalCalories = (selectedFood!.calories * servings).round();
    final totalProtein = (selectedFood!.protein * servings).round();
    final totalCarbs = (selectedFood!.carbs * servings).round();
    final totalFats = (selectedFood!.fats * servings).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.primary.withValues(alpha: 0.1),
            ColorPalette.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutrition Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NutrientDisplay(
                icon: Icons.local_fire_department,
                label: 'Calories',
                value: totalCalories.toString(),
                unit: 'kcal',
                color: Colors.orange,
              ),
              _NutrientDisplay(
                icon: Icons.fitness_center,
                label: 'Protein',
                value: totalProtein.toString(),
                unit: 'g',
                color: ColorPalette.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealTypeSelector() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2,
      children: mealTypes.map((type) {
        final isSelected = selectedMealType == type['id'];
        return InkWell(
          onTap: () {
            setState(() => selectedMealType = type['id'] as String);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorPalette.primary.withValues(alpha: 0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? ColorPalette.primary
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type['icon'] as IconData,
                  color: isSelected
                      ? ColorPalette.primary
                      : ColorPalette.textSecondary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  type['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isSelected
                        ? ColorPalette.primary
                        : ColorPalette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ServingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ServingButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: ColorPalette.primary,
        onPressed: onPressed,
      ),
    );
  }
}

class _NutrientDisplay extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _NutrientDisplay({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: color,
          ),
        ),
        Text(
          '$label ($unit)',
          style: const TextStyle(
            fontSize: 12,
            color: ColorPalette.textSecondary,
          ),
        ),
      ],
    );
  }
}

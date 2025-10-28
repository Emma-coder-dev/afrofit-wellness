import 'package:afrofit_wellness/features/nutrition/presentation/screens/add_meal_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../widgets/meal_card.dart';
import 'search_food_screen.dart';

class FoodDiaryScreen extends StatefulWidget {
  const FoodDiaryScreen({super.key});

  @override
  State<FoodDiaryScreen> createState() => _FoodDiaryScreenState();
}

class _FoodDiaryScreenState extends State<FoodDiaryScreen> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? dailyLog;
  List<Map<String, dynamic>> todaysMeals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      final user = await LocalStorageService.getUserData();
      final todayKey = LocalStorageService.getTodayKey();
      final log = await LocalStorageService.getDailyLog(todayKey);

      // Get meals from daily log
      final meals = <Map<String, dynamic>>[];
      if (log != null && log['meals'] != null) {
        meals.addAll((log['meals'] as List).cast<Map<String, dynamic>>());
      }

      setState(() {
        userData = user;
        dailyLog = log;
        todaysMeals = meals;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  Future<void> _deleteMeal(int index) async {
    try {
      todaysMeals.removeAt(index);
      
      // Recalculate totals
      int totalCalories = 0;
      int totalProtein = 0;
      
      for (var meal in todaysMeals) {
        totalCalories += (meal['calories'] as num).toInt();
        totalProtein += (meal['protein'] as num).toInt();
      }

      // Update daily log
      final todayKey = LocalStorageService.getTodayKey();
      final updatedLog = Map<String, dynamic>.from(dailyLog ?? {})
        ..['meals'] = todaysMeals
        ..['caloriesConsumed'] = totalCalories
        ..['proteinConsumed'] = totalProtein;

      await LocalStorageService.saveDailyLog(todayKey, updatedLog);
      
      setState(() {
        dailyLog = updatedLog;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Meal deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting meal: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final dailyGoals = userData?['dailyGoals'] as Map<String, dynamic>?;
    final caloriesGoal = dailyGoals?['calories'] as int? ?? 2000;
    final proteinGoal = dailyGoals?['protein'] as int? ?? 150;

    final caloriesConsumed = dailyLog?['caloriesConsumed'] as int? ?? 0;
    final proteinConsumed = dailyLog?['proteinConsumed'] as int? ?? 0;

    final caloriesRemaining = caloriesGoal - caloriesConsumed;
    final proteinRemaining = proteinGoal - proteinConsumed;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Food Diary',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // TODO: Show date picker
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Date picker coming soon!')),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Summary Card
              _buildDailySummary(
                caloriesConsumed,
                caloriesGoal,
                caloriesRemaining,
                proteinConsumed,
                proteinGoal,
                proteinRemaining,
              ),
              const SizedBox(height: 24),

              // Meals List
              _buildMealsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMealScreen(),
            ),
          );

          if (result == true) {
            _loadData(); // Reload data after adding meal
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Meal'),
        backgroundColor: ColorPalette.primary,
      ),
    );
  }

  Widget _buildDailySummary(
    int caloriesConsumed,
    int caloriesGoal,
    int caloriesRemaining,
    int proteinConsumed,
    int proteinGoal,
    int proteinRemaining,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.primary.withValues(alpha: 0.1),
            ColorPalette.secondary.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorPalette.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Today\'s Nutrition',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _NutritionStat(
                  icon: Icons.local_fire_department,
                  label: 'Calories',
                  consumed: caloriesConsumed,
                  goal: caloriesGoal,
                  remaining: caloriesRemaining,
                  unit: 'kcal',
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _NutritionStat(
                  icon: Icons.fitness_center,
                  label: 'Protein',
                  consumed: proteinConsumed,
                  goal: proteinGoal,
                  remaining: proteinRemaining,
                  unit: 'g',
                  color: ColorPalette.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealsList() {
    if (todaysMeals.isEmpty) {
      return EmptyState(
        icon: Icons.restaurant_outlined,
        title: 'No meals logged yet',
        message: 'Tap the button below to log your first meal',
        buttonText: 'Add Meal',
        onButtonPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMealScreen(),
            ),
          );

          if (result == true) {
            _loadData();
          }
        },
      );
    }

    // Group meals by type
    final breakfast = todaysMeals.where((m) => m['mealType'] == 'breakfast').toList();
    final lunch = todaysMeals.where((m) => m['mealType'] == 'lunch').toList();
    final dinner = todaysMeals.where((m) => m['mealType'] == 'dinner').toList();
    final snacks = todaysMeals.where((m) => m['mealType'] == 'snack').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (breakfast.isNotEmpty) ...[
          _buildMealSection('Breakfast', breakfast, Icons.free_breakfast),
          const SizedBox(height: 16),
        ],
        if (lunch.isNotEmpty) ...[
          _buildMealSection('Lunch', lunch, Icons.lunch_dining),
          const SizedBox(height: 16),
        ],
        if (dinner.isNotEmpty) ...[
          _buildMealSection('Dinner', dinner, Icons.dinner_dining),
          const SizedBox(height: 16),
        ],
        if (snacks.isNotEmpty) ...[
          _buildMealSection('Snacks', snacks, Icons.fastfood),
        ],
      ],
    );
  }

  Widget _buildMealSection(String title, List<Map<String, dynamic>> meals, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: ColorPalette.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...meals.asMap().entries.map((entry) {
          final index = todaysMeals.indexOf(entry.value);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: MealCard(
              meal: entry.value,
              onDelete: () => _deleteMeal(index),
            ),
          );
        }),
      ],
    );
  }
}

class _NutritionStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final int consumed;
  final int goal;
  final int remaining;
  final String unit;
  final Color color;

  const _NutritionStat({
    required this.icon,
    required this.label,
    required this.consumed,
    required this.goal,
    required this.remaining,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / goal).clamp(0.0, 1.0);

    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ColorPalette.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$consumed / $goal',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          unit,
          style: const TextStyle(
            fontSize: 11,
            color: ColorPalette.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          remaining > 0 ? '$remaining $unit left' : 'Goal reached!',
          style: TextStyle(
            fontSize: 11,
            color: remaining > 0 ? ColorPalette.textSecondary : ColorPalette.success,
            fontWeight: remaining > 0 ? FontWeight.normal : FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
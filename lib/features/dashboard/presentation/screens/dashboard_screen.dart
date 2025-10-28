import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../widgets/daily_stats_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/progress_circle.dart';
import '../widgets/motivational_card.dart';
import '../../../nutrition/presentation/screens/food_diary_screen.dart';
import '../../../workouts/presentation/screens/workout_list_screen.dart';
import '../../../progress/presentation/screens/progress_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? dailyLog;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    
    try {
      // Load user data - with proper type casting
      final user = await LocalStorageService.getUserData();
      
      // ✅ FIX: Properly cast LinkedMap to Map<String, dynamic>
      Map<String, dynamic>? userDataMap;
      if (user != null) {
        userDataMap = Map<String, dynamic>.from(user);
      }
      
      // Load or create today's log
      final todayKey = LocalStorageService.getTodayKey();
      var log = await LocalStorageService.getDailyLog(todayKey);
      
      // ✅ FIX: Also cast the log data properly
      Map<String, dynamic>? logDataMap;
      if (log != null) {
        logDataMap = Map<String, dynamic>.from(log);
      } else {
        // Create empty log for today
        logDataMap = {
          'date': DateTime.now().toIso8601String(),
          'caloriesConsumed': 0,
          'proteinConsumed': 0,
          'waterConsumed': 0,
          'workoutCompleted': false,
          'workoutDuration': 0,
          'caloriesBurned': 0,
        };
        await LocalStorageService.saveDailyLog(todayKey, logDataMap);
      }
      
      setState(() {
        userData = userDataMap;
        dailyLog = logDataMap;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading dashboard data: $e');
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userData == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No user data found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to onboarding
                  Navigator.pushReplacementNamed(context, '/onboarding');
                },
                child: const Text('Complete Onboarding'),
              ),
            ],
          ),
        ),
      );
    }

    // ✅ FIX: PROPERLY cast dailyGoals with safe conversion
    final dailyGoalsRaw = userData?['dailyGoals'];
    Map<String, dynamic> dailyGoals;
    if (dailyGoalsRaw != null && dailyGoalsRaw is Map) {
      dailyGoals = Map<String, dynamic>.from(dailyGoalsRaw);
    } else {
      dailyGoals = {
        'calories': 2000,
        'protein': 50,
        'water': 2000,
      };
    }

    final caloriesGoal = (dailyGoals['calories'] as int?) ?? 2000;
    final proteinGoal = (dailyGoals['protein'] as int?) ?? 50;
    final waterGoal = (dailyGoals['water'] as int?) ?? 2000;

    final caloriesConsumed = dailyLog?['caloriesConsumed'] as int? ?? 0;
    final proteinConsumed = dailyLog?['proteinConsumed'] as int? ?? 0;
    final waterConsumed = dailyLog?['waterConsumed'] as int? ?? 0;
    final workoutCompleted = dailyLog?['workoutCompleted'] as bool? ?? false;
    final caloriesBurned = dailyLog?['caloriesBurned'] as int? ?? 0;

    // Calculate net calories (consumed - burned)
    final netCalories = caloriesConsumed - caloriesBurned;

    return Scaffold(
      appBar: CustomAppBar(
        title: StringConstants.appName,
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
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
              // Welcome Section
              _buildWelcomeSection(),
              const SizedBox(height: 24),

              // Daily Stats Overview
              _buildDailyStatsOverview(
                caloriesConsumed: caloriesConsumed,
                caloriesGoal: caloriesGoal,
                caloriesBurned: caloriesBurned,
                waterConsumed: waterConsumed,
                waterGoal: waterGoal,
                workoutCompleted: workoutCompleted,
              ),
              const SizedBox(height: 24),

              // Nutrition Progress
              _buildNutritionProgress(
                caloriesConsumed: netCalories,
                caloriesGoal: caloriesGoal,
                proteinConsumed: proteinConsumed,
                proteinGoal: proteinGoal,
              ),
              const SizedBox(height: 24),

              // Quick Actions
              _buildQuickActions(),
              const SizedBox(height: 24),

              // Motivational Card
              MotivationalCard(
                currentWeight: (userData?['currentWeight'] as num?)?.toDouble() ?? 0.0,
                targetWeight: (userData?['targetWeight'] as num?)?.toDouble() ?? 0.0,
                bodyShape: (userData?['desiredBodyShape'] as String?) ?? 'slim',
              ),
              const SizedBox(height: 24),

              // Today's Workout
              _buildTodaysWorkout(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildWelcomeSection() {
    // ✅ FIX: Add null safety with proper casting
    final name = (userData?['name'] as String?) ?? 'User';
    final currentWeight = (userData?['currentWeight'] as num?)?.toDouble() ?? 0.0;
    final targetWeight = (userData?['targetWeight'] as num?)?.toDouble() ?? 0.0;
    final weightToLose = currentWeight - targetWeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good ${_getTimeOfDay()}, $name! 👋',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 169, 228, 163),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          weightToLose > 0
              ? 'You\'re ${weightToLose.toStringAsFixed(1)}kg away from your goal'
              : 'You\'ve reached your goal weight! 🎉',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorPalette.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildDailyStatsOverview({
    required int caloriesConsumed,
    required int caloriesGoal,
    required int caloriesBurned,
    required int waterConsumed,
    required int waterGoal,
    required bool workoutCompleted,
  }) {
    return DailyStatsCard(
      caloriesConsumed: caloriesConsumed,
      caloriesGoal: caloriesGoal,
      caloriesBurned: caloriesBurned,
      waterConsumed: waterConsumed,
      waterGoal: waterGoal,
      workoutCompleted: workoutCompleted,
    );
  }

  Widget _buildNutritionProgress({
    required int caloriesConsumed,
    required int caloriesGoal,
    required int proteinConsumed,
    required int proteinGoal,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Nutrition',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ProgressCircle(
                  value: caloriesConsumed.toDouble(),
                  total: caloriesGoal.toDouble(),
                  label: 'Calories',
                  unit: 'kcal',
                  color: ColorPalette.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ProgressCircle(
                  value: proteinConsumed.toDouble(),
                  total: proteinGoal.toDouble(),
                  label: 'Protein',
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

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            QuickActionCard(
              icon: Icons.restaurant_outlined,
              title: 'Log Meal',
              subtitle: 'Track your food',
              color: ColorPalette.primary,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodDiaryScreen(),
                  ),
                );
                if (result == true) {
                  _loadData(); // Reload dashboard data
                }
              },
            ),
            QuickActionCard(
              icon: Icons.fitness_center_outlined,
              title: 'Workout',
              subtitle: 'Start exercising',
              color: ColorPalette.secondary,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkoutListScreen(),
                  ),
                );
                if (result == true) {
                  _loadData(); // Reload dashboard data
                }
              },
            ),
            QuickActionCard(
              icon: Icons.water_drop_outlined,
              title: 'Add Water',
              subtitle: 'Stay hydrated',
              color: Colors.blue,
              onTap: () => _showAddWaterDialog(),
            ),
            QuickActionCard(
              icon: Icons.trending_up_outlined,
              title: 'Progress',
              subtitle: 'View stats',
              color: ColorPalette.accent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProgressScreen(),
                  ),
                ).then((_) => _loadData());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaysWorkout() {
    // ✅ FIX: Add null safety with proper casting
    final bodyShape = (userData?['desiredBodyShape'] as String?) ?? 'slim';
    final problemAreasRaw = userData?['problemAreas'];
    final problemAreas = (problemAreasRaw is List?) ? problemAreasRaw?.cast<String>() ?? [] : [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.primary,
            ColorPalette.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Today\'s Workout',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Personalized for ${_getBodyShapeName(bodyShape)}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                const Text(
                  '20 min • Bodyweight',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkoutListScreen(),
                  ),
                );
                if (result == true) {
                  _loadData(); // Reload dashboard data
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ColorPalette.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Workout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getBodyShapeName(String shape) {
    switch (shape) {
      case 'hourglass':
        return 'Hourglass Shape';
      case 'athletic':
        return 'Athletic Build';
      case 'slim':
        return 'Slim Figure';
      case 'curvy':
        return 'Curvy Body';
      case 'pear':
        return 'Pear Shape';
      case 'apple':
        return 'Apple Shape';
      default:
        return 'Your Goals';
    }
  }

  void _showAddWaterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Water'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select amount to add:'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _WaterButton(amount: 250, onPressed: _addWater),
                _WaterButton(amount: 500, onPressed: _addWater),
                _WaterButton(amount: 750, onPressed: _addWater),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _addWater(int amount) async {
    Navigator.pop(context);
    
    final todayKey = LocalStorageService.getTodayKey();
    final currentWater = dailyLog?['waterConsumed'] as int? ?? 0;
    
    final updatedLog = Map<String, dynamic>.from(dailyLog ?? {})
      ..['waterConsumed'] = currentWater + amount;
    
    await LocalStorageService.saveDailyLog(todayKey, updatedLog);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${amount}ml of water! 💧')),
      );
      _loadData();
    }
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: ColorPalette.primary,
      unselectedItemColor: ColorPalette.textSecondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_outlined),
          activeIcon: Icon(Icons.restaurant),
          label: 'Nutrition',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center_outlined),
          activeIcon: Icon(Icons.fitness_center),
          label: 'Workouts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up_outlined),
          activeIcon: Icon(Icons.trending_up),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        if (index == 0) return; // Already on home
        
        switch (index) {
          case 1: // Nutrition
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FoodDiaryScreen(),
              ),
            ).then((_) => _loadData());
            break;
          case 2: // Workouts
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WorkoutListScreen(),
              ),
            ).then((_) => _loadData());
            break;
          case 3: // Progress
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProgressScreen(),
              ),
            ).then((_) => _loadData());
            break;
          case 4: // Profile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            ).then((_) => _loadData());
            break;
        }
      },
    );
  }
}

class _WaterButton extends StatelessWidget {
  final int amount;
  final Function(int) onPressed;

  const _WaterButton({
    required this.amount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade50,
        foregroundColor: Colors.blue.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        '${amount}ml',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
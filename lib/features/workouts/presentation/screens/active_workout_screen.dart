import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../../data/models/exercise_model.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  final List<ExerciseModel> exercises;

  const ActiveWorkoutScreen({
    super.key,
    required this.exercises,
  });

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int currentExerciseIndex = 0;
  int currentReps = 0;
  int currentSeconds = 0;
  Timer? timer;
  bool isResting = false;
  bool isPaused = false;
  bool isWorkoutComplete = false;
  int restTimeRemaining = 30; // 30 seconds rest between exercises
  int totalCaloriesBurned = 0;
  DateTime? workoutStartTime;

  @override
  void initState() {
    super.initState();
    workoutStartTime = DateTime.now();
    _startExercise();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Helper methods for exercise type detection
  bool get _isTimeBased => currentExercise.defaultDuration > 0;
  bool get _isRepBased => currentExercise.reps != null && currentExercise.reps! > 0;

  ExerciseModel get currentExercise {
    if (widget.exercises.isEmpty) {
      return ExerciseModel(
        id: 'default',
        name: 'Default Exercise',
        description: 'No exercises available',
        targetAreas: ['full-body'],
        category: 'general',
        difficulty: 'beginner',
        caloriesPerMinute: 0,
        defaultDuration: 30,
        reps: 10,
        sets: 3,
      );
    }
    
    if (currentExerciseIndex >= widget.exercises.length) {
      return widget.exercises.last;
    }
    
    return widget.exercises[currentExerciseIndex];
  }

  void _startExercise() {
    setState(() {
      currentReps = 0;
      currentSeconds = 0;
      isPaused = false;
    });

    if (_isTimeBased) {
      _startTimer();
    }
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          currentSeconds++;
          
          final minutesElapsed = currentSeconds / 60;
          totalCaloriesBurned = (currentExercise.caloriesPerMinute * minutesElapsed).round();

          if (_isTimeBased && currentSeconds >= currentExercise.defaultDuration) {
            _completeExercise();
          }
        });
      }
    });
  }

  void _completeExercise() {
    timer?.cancel();

    if (widget.exercises.isEmpty) {
      _finishWorkout();
      return;
    }

    if (currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        isResting = true;
        restTimeRemaining = 30;
      });
      _startRestTimer();
    } else {
      _finishWorkout();
    }
  }

  void _startRestTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        restTimeRemaining--;
        if (restTimeRemaining <= 0) {
          timer.cancel();
          isResting = false;
          
          if (currentExerciseIndex < widget.exercises.length - 1) {
            currentExerciseIndex++;
            _startExercise();
          } else {
            _finishWorkout();
          }
        }
      });
    });
  }

  void _skipRest() {
    timer?.cancel();
    
    if (currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        isResting = false;
        currentExerciseIndex++;
      });
      _startExercise();
    } else {
      _finishWorkout();
    }
  }

  Future<void> _finishWorkout() async {
    timer?.cancel();
    setState(() {
      isWorkoutComplete = true;
    });

    try {
      final workoutDuration = DateTime.now().difference(workoutStartTime!).inMinutes;
      
      int totalCalories = 0;
      for (var exercise in widget.exercises) {
        if (exercise.reps != null && exercise.reps! > 0) {
          final duration = exercise.reps! * 2;
          totalCalories += (exercise.caloriesPerMinute * (duration / 60)).round();
        } else {
          totalCalories += (exercise.caloriesPerMinute * (exercise.defaultDuration / 60)).round();
        }
      }

      final todayKey = LocalStorageService.getTodayKey();
      var dailyLog = await LocalStorageService.getDailyLog(todayKey);

      dailyLog ??= {
        'date': DateTime.now().toIso8601String(),
        'caloriesConsumed': 0,
        'proteinConsumed': 0,
        'waterConsumed': 0,
        'workoutCompleted': false,
        'workoutDuration': 0,
        'caloriesBurned': 0,
        'meals': [],
      };

      dailyLog['workoutCompleted'] = true;
      dailyLog['workoutDuration'] = workoutDuration;
      dailyLog['caloriesBurned'] = totalCalories;

      await LocalStorageService.saveDailyLog(todayKey, dailyLog);

      if (mounted) {
        _showCompletionDialog(workoutDuration, totalCalories);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving workout: $e')),
        );
      }
    }
  }

  void _showCompletionDialog(int duration, int calories) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.celebration, size: 64, color: ColorPalette.warning),
            SizedBox(height: 16),
            Text(
              'Workout Complete! 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Great job! You\'ve completed your workout!',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorPalette.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatBadge(
                  icon: Icons.timer,
                  label: 'Duration',
                  value: '$duration min',
                  color: ColorPalette.primary,
                ),
                _StatBadge(
                  icon: Icons.local_fire_department,
                  label: 'Burned',
                  value: '$calories cal',
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isResting) {
      return _buildRestScreen();
    }

    if (isWorkoutComplete) {
      return _buildCompletionScreen();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await _showExitDialog();
          if (shouldExit == true && mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Workout in Progress',
          showBackButton: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                final shouldExit = await _showExitDialog();
                if (shouldExit == true && context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Exercise ${currentExerciseIndex + 1} of ${widget.exercises.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorPalette.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentExercise.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    if (_isTimeBased)
                      _buildTimer()
                    else
                      _buildRepCounter(),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.info_outline, color: ColorPalette.primary),
                              SizedBox(width: 8),
                              Text(
                                'How to Perform',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            currentExercise.description,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildStats(),
                  ],
                ),
              ),
            ),
            _buildControlButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = widget.exercises.isNotEmpty 
        ? (currentExerciseIndex + 1) / widget.exercises.length 
        : 0.0;
        
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${((progress * 100).round())}% Complete',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primary,
                ),
              ),
              Text(
                '${currentExerciseIndex + 1}/${widget.exercises.length}',
                style: const TextStyle(
                  color: ColorPalette.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: ColorPalette.primary.withValues(alpha: 0.1),
          valueColor: const AlwaysStoppedAnimation<Color>(ColorPalette.primary),
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildTimer() {
    final targetDuration = currentExercise.defaultDuration;
    final progress = currentSeconds / targetDuration;
    final remaining = targetDuration - currentSeconds;

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    remaining <= 10 ? Colors.red : ColorPalette.primary,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    remaining.toString(),
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: remaining <= 10 ? Colors.red : ColorPalette.primary,
                    ),
                  ),
                  Text(
                    'seconds left',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRepCounter() {
    final targetReps = currentExercise.reps ?? 10;
    final progress = targetReps > 0 ? currentReps / targetReps : 0.0;

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(ColorPalette.secondary),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentReps.toString(),
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.secondary,
                    ),
                  ),
                  Text(
                    '/ $targetReps reps',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'decrease',
              onPressed: currentReps > 0
                  ? () {
                      setState(() => currentReps--);
                    }
                  : null,
              backgroundColor: currentReps > 0 ? Colors.red.shade400 : Colors.grey.shade300,
              child: const Icon(Icons.remove, size: 32),
            ),
            const SizedBox(width: 32),
            FloatingActionButton(
              heroTag: 'increase',
              onPressed: () {
                setState(() => currentReps++);
              },
              backgroundColor: ColorPalette.secondary,
              child: const Icon(Icons.add, size: 32),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats() {
    final minutesElapsed = (DateTime.now().difference(workoutStartTime!).inSeconds / 60);
    final estimatedCalories = (currentExercise.caloriesPerMinute * minutesElapsed).round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatCard(
          icon: Icons.timer,
          label: 'Time',
          value: '${minutesElapsed.toInt()} min',
          color: ColorPalette.primary,
        ),
        _StatCard(
          icon: Icons.local_fire_department,
          label: 'Calories',
          value: '$estimatedCalories kcal',
          color: Colors.orange,
        ),
        _StatCard(
          icon: Icons.fitness_center,
          label: 'Exercises',
          value: '${currentExerciseIndex + 1}/${widget.exercises.length}',
          color: ColorPalette.secondary,
        ),
      ],
    );
  }

  Widget _buildControlButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_isTimeBased) ...[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    isPaused = !isPaused;
                  });
                },
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                label: Text(isPaused ? 'Resume' : 'Pause'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ColorPalette.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_isTimeBased) {
                  _completeExercise();
                } else if (_isRepBased) {
                  final targetReps = currentExercise.reps!;
                  
                  if (currentReps < targetReps) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Incomplete Exercise'),
                        content: Text('You\'ve done $currentReps/$targetReps reps. Skip anyway?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Keep Going'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _completeExercise();
                            },
                            child: const Text('Skip'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  _completeExercise();
                } else {
                  _completeExercise();
                }
              },
              icon: Icon(
                currentExerciseIndex == widget.exercises.length - 1
                    ? Icons.check
                    : Icons.arrow_forward,
              ),
              label: Text(
                currentExerciseIndex == widget.exercises.length - 1
                    ? 'Complete Workout'
                    : 'Next Exercise',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestScreen() {
    String nextExerciseName = 'No more exercises';
    if (currentExerciseIndex < widget.exercises.length - 1) {
      nextExerciseName = widget.exercises[currentExerciseIndex + 1].name;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.secondary.withValues(alpha: 0.2),
              ColorPalette.primary.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.self_improvement,
                    size: 60,
                    color: ColorPalette.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Rest Time',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Take a breath and get ready',
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorPalette.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: 1 - (restTimeRemaining / 30),
                            strokeWidth: 12,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(ColorPalette.secondary),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              restTimeRemaining.toString(),
                              style: const TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.secondary,
                              ),
                            ),
                            Text(
                              'seconds',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (currentExerciseIndex < widget.exercises.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Next Exercise:',
                            style: TextStyle(
                              fontSize: 13,
                              color: ColorPalette.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            nextExerciseName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _skipRest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          currentExerciseIndex < widget.exercises.length - 1 
                              ? 'Skip Rest' 
                              : 'Finish Workout',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.success.withValues(alpha: 0.2),
              ColorPalette.primary.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showExitDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Workout?'),
        content: const Text('Are you sure you want to exit? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: ColorPalette.error),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: ColorPalette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: ColorPalette.textSecondary,
          ),
        ),
      ],
    );
  }
}
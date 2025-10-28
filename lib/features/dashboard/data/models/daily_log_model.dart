import 'package:hive/hive.dart';

part 'daily_log_model.g.dart'; // For Hive code generation

@HiveType(typeId: 4)
class DailyLogModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final DateTime date;

  // Nutrition tracking
  @HiveField(3)
  final double caloriesConsumed;

  @HiveField(4)
  final double proteinConsumed;

  @HiveField(5)
  final double carbsConsumed;

  @HiveField(6)
  final double fatsConsumed;

  // Hydration tracking
  @HiveField(7)
  final int waterConsumedMl;

  // Workout tracking
  @HiveField(8)
  final bool workoutCompleted;

  @HiveField(9)
  final int workoutDurationMinutes;

  @HiveField(10)
  final int caloriesBurned;

  // Sleep tracking
  @HiveField(11)
  final double? sleepHours;

  @HiveField(12)
  final int? sleepQuality; // 1-5 rating

  // Additional tracking
  @HiveField(13)
  final int steps;

  @HiveField(14)
  final String? mood; // 'great', 'good', 'okay', 'bad'

  @HiveField(15)
  final List<String>? notes;

  DailyLogModel({
    required this.id,
    required this.userId,
    required this.date,
    this.caloriesConsumed = 0,
    this.proteinConsumed = 0,
    this.carbsConsumed = 0,
    this.fatsConsumed = 0,
    this.waterConsumedMl = 0,
    this.workoutCompleted = false,
    this.workoutDurationMinutes = 0,
    this.caloriesBurned = 0,
    this.sleepHours,
    this.sleepQuality,
    this.steps = 0,
    this.mood,
    this.notes,
  });

  // Calculate net calories (consumed - burned)
  double get netCalories => caloriesConsumed - caloriesBurned;

  // Calculate water glasses (250ml per glass)
  int get waterGlasses => waterConsumedMl ~/ 250;

  // Check if daily goals are met
  bool isCalorieGoalMet(double calorieGoal) {
    return caloriesConsumed <= calorieGoal && caloriesConsumed >= (calorieGoal * 0.8);
  }

  bool isProteinGoalMet(double proteinGoal) {
    return proteinConsumed >= proteinGoal;
  }

  bool isWaterGoalMet(int waterGoalMl) {
    return waterConsumedMl >= waterGoalMl;
  }

  bool isWorkoutGoalMet() {
    return workoutCompleted;
  }

  bool isSleepGoalMet(int sleepGoalHours) {
    return sleepHours != null && sleepHours! >= sleepGoalHours;
  }

  // Calculate overall daily score (0-100)
  int calculateDailyScore({
    required double calorieGoal,
    required double proteinGoal,
    required int waterGoalMl,
    required int sleepGoalHours,
  }) {
    int score = 0;

    // Calorie goal (25 points)
    if (isCalorieGoalMet(calorieGoal)) score += 25;

    // Protein goal (20 points)
    if (isProteinGoalMet(proteinGoal)) score += 20;

    // Water goal (20 points)
    if (isWaterGoalMet(waterGoalMl)) score += 20;

    // Workout goal (25 points)
    if (isWorkoutGoalMet()) score += 25;

    // Sleep goal (10 points)
    if (isSleepGoalMet(sleepGoalHours)) score += 10;

    return score;
  }

  // Get formatted date
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'caloriesConsumed': caloriesConsumed,
      'proteinConsumed': proteinConsumed,
      'carbsConsumed': carbsConsumed,
      'fatsConsumed': fatsConsumed,
      'waterConsumedMl': waterConsumedMl,
      'workoutCompleted': workoutCompleted,
      'workoutDurationMinutes': workoutDurationMinutes,
      'caloriesBurned': caloriesBurned,
      'sleepHours': sleepHours,
      'sleepQuality': sleepQuality,
      'steps': steps,
      'mood': mood,
      'notes': notes,
    };
  }

  // Create from JSON
  factory DailyLogModel.fromJson(Map<String, dynamic> json) {
    return DailyLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      caloriesConsumed: (json['caloriesConsumed'] as num?)?.toDouble() ?? 0,
      proteinConsumed: (json['proteinConsumed'] as num?)?.toDouble() ?? 0,
      carbsConsumed: (json['carbsConsumed'] as num?)?.toDouble() ?? 0,
      fatsConsumed: (json['fatsConsumed'] as num?)?.toDouble() ?? 0,
      waterConsumedMl: json['waterConsumedMl'] as int? ?? 0,
      workoutCompleted: json['workoutCompleted'] as bool? ?? false,
      workoutDurationMinutes: json['workoutDurationMinutes'] as int? ?? 0,
      caloriesBurned: json['caloriesBurned'] as int? ?? 0,
      sleepHours: (json['sleepHours'] as num?)?.toDouble(),
      sleepQuality: json['sleepQuality'] as int?,
      steps: json['steps'] as int? ?? 0,
      mood: json['mood'] as String?,
      notes: json['notes'] != null ? List<String>.from(json['notes'] as List) : null,
    );
  }

  // Copy with method
  DailyLogModel copyWith({
    String? id,
    String? userId,
    DateTime? date,
    double? caloriesConsumed,
    double? proteinConsumed,
    double? carbsConsumed,
    double? fatsConsumed,
    int? waterConsumedMl,
    bool? workoutCompleted,
    int? workoutDurationMinutes,
    int? caloriesBurned,
    double? sleepHours,
    int? sleepQuality,
    int? steps,
    String? mood,
    List<String>? notes,
  }) {
    return DailyLogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      caloriesConsumed: caloriesConsumed ?? this.caloriesConsumed,
      proteinConsumed: proteinConsumed ?? this.proteinConsumed,
      carbsConsumed: carbsConsumed ?? this.carbsConsumed,
      fatsConsumed: fatsConsumed ?? this.fatsConsumed,
      waterConsumedMl: waterConsumedMl ?? this.waterConsumedMl,
      workoutCompleted: workoutCompleted ?? this.workoutCompleted,
      workoutDurationMinutes: workoutDurationMinutes ?? this.workoutDurationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      steps: steps ?? this.steps,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'DailyLogModel(id: $id, date: $formattedDate, calories: $caloriesConsumed, workout: $workoutCompleted)';
  }
}
import 'package:hive/hive.dart';

part 'user_model.g.dart'; // For Hive code generation

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final double currentWeight; // kg

  @HiveField(4)
  final double targetWeight; // kg

  @HiveField(5)
  final double height; // cm

  @HiveField(6)
  final String gender; // 'male', 'female', 'other'

  @HiveField(7)
  final String activityLevel; // 'sedentary', 'lightly_active', etc.

  @HiveField(8)
  final String desiredBodyShape; // 'hourglass', 'athletic', etc.

  @HiveField(9)
  final List<String> problemAreas; // ['belly_fat', 'love_handles', etc.]

  @HiveField(10)
  final DateTime createdAt;

  @HiveField(11)
  final DateTime? lastUpdated;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.currentWeight,
    required this.targetWeight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.desiredBodyShape,
    required this.problemAreas,
    required this.createdAt,
    this.lastUpdated,
  });

  // Calculate BMI (Body Mass Index)
  double get bmi {
    final heightInMeters = height / 100;
    return currentWeight / (heightInMeters * heightInMeters);
  }

  // Get BMI category
  String get bmiCategory {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal Weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  // Calculate daily calorie needs (using Harris-Benedict equation)
  double calculateDailyCalories() {
    double bmr;

    // Calculate Basal Metabolic Rate (BMR)
    if (gender == 'male') {
      bmr = 88.362 + (13.397 * currentWeight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * currentWeight) + (3.098 * height) - (4.330 * age);
    }

    // Apply activity multiplier
    double activityMultiplier = _getActivityMultiplier();
    double maintenanceCalories = bmr * activityMultiplier;

    // Create 500 calorie deficit for weight loss (0.5kg/week)
    return maintenanceCalories - 500;
  }

  // Get activity multiplier based on user's activity level
  double _getActivityMultiplier() {
    switch (activityLevel) {
      case 'sedentary':
        return 1.2;
      case 'lightly_active':
        return 1.375;
      case 'moderately_active':
        return 1.55;
      case 'very_active':
        return 1.725;
      default:
        return 1.2;
    }
  }

  // Calculate daily protein goal (2g per kg body weight)
  double calculateDailyProtein() {
    return currentWeight * 2.0; // grams
  }

  // Calculate daily water goal (35ml per kg body weight)
  int calculateDailyWater() {
    return (currentWeight * 35).round(); // ml
  }

  // Calculate weeks to goal
  int calculateWeeksToGoal() {
    final weightToLose = (currentWeight - targetWeight).abs();
    const healthyWeightLossPerWeek = 0.5; // kg
    return (weightToLose / healthyWeightLossPerWeek).ceil();
  }

  // Calculate estimated goal date
  DateTime get estimatedGoalDate {
    final weeksToGoal = calculateWeeksToGoal();
    return createdAt.add(Duration(days: weeksToGoal * 7));
  }

  // Get daily goals as a map
  Map<String, dynamic> get dailyGoals {
    return {
      'calories': calculateDailyCalories().round(),
      'protein': calculateDailyProtein().round(),
      'water': calculateDailyWater(),
      'sleep': 8, // hours
      'workout': 1, // sessions
    };
  }

  // Convert to JSON (for Firebase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'currentWeight': currentWeight,
      'targetWeight': targetWeight,
      'height': height,
      'gender': gender,
      'activityLevel': activityLevel,
      'desiredBodyShape': desiredBodyShape,
      'problemAreas': problemAreas,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  // Create from JSON (for Firebase)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      currentWeight: (json['currentWeight'] as num).toDouble(),
      targetWeight: (json['targetWeight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      gender: json['gender'] as String,
      activityLevel: json['activityLevel'] as String,
      desiredBodyShape: json['desiredBodyShape'] as String,
      problemAreas: List<String>.from(json['problemAreas'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  // Copy with method (for updates)
  UserModel copyWith({
    String? id,
    String? name,
    int? age,
    double? currentWeight,
    double? targetWeight,
    double? height,
    String? gender,
    String? activityLevel,
    String? desiredBodyShape,
    List<String>? problemAreas,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      currentWeight: currentWeight ?? this.currentWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      desiredBodyShape: desiredBodyShape ?? this.desiredBodyShape,
      problemAreas: problemAreas ?? this.problemAreas,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, age: $age, currentWeight: $currentWeight, targetWeight: $targetWeight)';
  }
}
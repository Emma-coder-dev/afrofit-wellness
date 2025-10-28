import 'package:hive/hive.dart';
import 'food_model.dart';

part 'meal_model.g.dart'; // For Hive code generation

@HiveType(typeId: 1)
class MealModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String foodId; // Reference to FoodModel

  @HiveField(3)
  final String foodName; // Stored for quick access

  @HiveField(4)
  final double servings; // e.g., 1.5 (1.5 cups)

  @HiveField(5)
  final String mealType; // 'Breakfast', 'Lunch', 'Dinner', 'Snacks'

  @HiveField(6)
  final DateTime timestamp;

  @HiveField(7)
  final double calories; // Total calories for this meal entry

  @HiveField(8)
  final double protein; // Total protein for this meal entry

  @HiveField(9)
  final double carbs; // Total carbs for this meal entry

  @HiveField(10)
  final double fats; // Total fats for this meal entry

  @HiveField(11)
  final String? notes; // Optional user notes

  MealModel({
    required this.id,
    required this.userId,
    required this.foodId,
    required this.foodName,
    required this.servings,
    required this.mealType,
    required this.timestamp,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    this.notes,
  });

  // Create meal from food model and servings
  factory MealModel.fromFood({
    required String id,
    required String userId,
    required FoodModel food,
    required double servings,
    required String mealType,
    String? notes,
  }) {
    return MealModel(
      id: id,
      userId: userId,
      foodId: food.id,
      foodName: food.name,
      servings: servings,
      mealType: mealType,
      timestamp: DateTime.now(),
      calories: food.calories * servings,
      protein: food.protein * servings,
      carbs: food.carbs * servings,
      fats: food.fats * servings,
      notes: notes,
    );
  }

  // Get nutrition summary
  String get nutritionSummary {
    return 'Cal: ${calories.toInt()} | P: ${protein.toInt()}g | C: ${carbs.toInt()}g | F: ${fats.toInt()}g';
  }

  // Get display text
  String get displayText {
    return '$foodName (${servings}x servings)';
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foodId': foodId,
      'foodName': foodName,
      'servings': servings,
      'mealType': mealType,
      'timestamp': timestamp.toIso8601String(),
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'notes': notes,
    };
  }

  // Create from JSON
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      foodId: json['foodId'] as String,
      foodName: json['foodName'] as String,
      servings: (json['servings'] as num).toDouble(),
      mealType: json['mealType'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      notes: json['notes'] as String?,
    );
  }

  // Copy with method
  MealModel copyWith({
    String? id,
    String? userId,
    String? foodId,
    String? foodName,
    double? servings,
    String? mealType,
    DateTime? timestamp,
    double? calories,
    double? protein,
    double? carbs,
    double? fats,
    String? notes,
  }) {
    return MealModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      servings: servings ?? this.servings,
      mealType: mealType ?? this.mealType,
      timestamp: timestamp ?? this.timestamp,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'MealModel(id: $id, foodName: $foodName, servings: $servings, mealType: $mealType, calories: $calories)';
  }
}
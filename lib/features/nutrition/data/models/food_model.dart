class FoodModel {
  final String id;
  final String name; // English name
  final Map<String, String> localNames; // {language: localName}
  final String portionSize; // e.g., "1 cup (250g)"
  final double calories;
  final double protein; // grams
  final double carbs; // grams
  final double fats; // grams
  final double fiber; // grams
  final String category; // 'staple', 'protein', 'vegetable', 'fruit', 'snack'
  final String region; // 'east_africa', 'west_africa', 'south_africa', 'north_africa'
  final String? description;
  final String? imagePath;

  FoodModel({
    required this.id,
    required this.name,
    required this.localNames,
    required this.portionSize,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    this.fiber = 0,
    required this.category,
    required this.region,
    this.description,
    this.imagePath,
  });

  // Calculate macronutrient percentages
  Map<String, double> get macroPercentages {
    final totalCalories = (protein * 4) + (carbs * 4) + (fats * 9);
    return {
      'protein': totalCalories > 0 ? (protein * 4 / totalCalories * 100) : 0,
      'carbs': totalCalories > 0 ? (carbs * 4 / totalCalories * 100) : 0,
      'fats': totalCalories > 0 ? (fats * 9 / totalCalories * 100) : 0,
    };
  }

  // Check if food is high protein (>15g per serving)
  bool get isHighProtein => protein >= 15;

  // Check if food is low calorie (<100 cal per serving)
  bool get isLowCalorie => calories < 100;

  // Check if food is high fiber (>5g per serving)
  bool get isHighFiber => fiber >= 5;

  // Get nutrition summary
  String get nutritionSummary {
    return 'Calories: ${calories.toInt()}cal | Protein: ${protein.toInt()}g | Carbs: ${carbs.toInt()}g | Fats: ${fats.toInt()}g';
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'localNames': localNames,
      'portionSize': portionSize,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
      'category': category,
      'region': region,
      'description': description,
      'imagePath': imagePath,
    };
  }

  // Create from JSON
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      localNames: Map<String, String>.from(json['localNames'] as Map),
      portionSize: json['portionSize'] as String,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0,
      category: json['category'] as String,
      region: json['region'] as String,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
    );
  }

  // Copy with method
  FoodModel copyWith({
    String? id,
    String? name,
    Map<String, String>? localNames,
    String? portionSize,
    double? calories,
    double? protein,
    double? carbs,
    double? fats,
    double? fiber,
    String? category,
    String? region,
    String? description,
    String? imagePath,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      localNames: localNames ?? this.localNames,
      portionSize: portionSize ?? this.portionSize,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      fiber: fiber ?? this.fiber,
      category: category ?? this.category,
      region: region ?? this.region,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, calories: $calories, region: $region)';
  }
}
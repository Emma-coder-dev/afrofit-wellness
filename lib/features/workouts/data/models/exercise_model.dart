class ExerciseModel {
  final String id;
  final String name;
  final String description; // How to perform the exercise
  final List<String> targetAreas; // ['glutes', 'thighs', 'core', etc.]
  final String category; // 'warmup', 'core', 'upper_body', 'lower_body', 'cardio', 'cooldown'
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final double caloriesPerMinute; // Estimated calories burned per minute
  final int defaultDuration; // Default duration in seconds
  final int? reps; // Number of reps (if applicable)
  final int? sets; // Number of sets (if applicable)
  final String? imagePath;
  final String? videoUrl;
  final List<String> tips; // Exercise tips
  final List<String> modifications; // Easier/harder variations

  ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.targetAreas,
    required this.category,
    required this.difficulty,
    required this.caloriesPerMinute,
    required this.defaultDuration,
    this.reps,
    this.sets,
    this.imagePath,
    this.videoUrl,
    this.tips = const [],
    this.modifications = const [],
  });

  // Calculate calories burned for custom duration
  double calculateCalories(int durationSeconds) {
    return caloriesPerMinute * (durationSeconds / 60);
  }

  // Get display duration
  String get displayDuration {
    if (reps != null) {
      return '$reps reps${sets != null ? ' x $sets sets' : ''}';
    }
    final minutes = defaultDuration ~/ 60;
    final seconds = defaultDuration % 60;
    if (minutes > 0 && seconds > 0) {
      return '${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${seconds}s';
    }
  }

  // Get difficulty color
  String get difficultyColor {
    switch (difficulty) {
      case 'beginner':
        return '#4CAF50'; // Green
      case 'intermediate':
        return '#FF9800'; // Orange
      case 'advanced':
        return '#F44336'; // Red
      default:
        return '#757575'; // Gray
    }
  }

  // Get category display name
  String get categoryDisplayName {
    switch (category) {
      case 'warmup':
        return 'Warm-up';
      case 'core':
        return 'Core';
      case 'upper_body':
        return 'Upper Body';
      case 'lower_body':
        return 'Lower Body';
      case 'cardio':
        return 'Cardio';
      case 'cooldown':
        return 'Cool-down';
      default:
        return category;
    }
  }

  // Check if exercise targets specific area
  bool targetsArea(String area) {
    return targetAreas.contains(area);
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'targetAreas': targetAreas,
      'category': category,
      'difficulty': difficulty,
      'caloriesPerMinute': caloriesPerMinute,
      'defaultDuration': defaultDuration,
      'reps': reps,
      'sets': sets,
      'imagePath': imagePath,
      'videoUrl': videoUrl,
      'tips': tips,
      'modifications': modifications,
    };
  }

  // Create from JSON
  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      targetAreas: List<String>.from(json['targetAreas'] as List),
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      caloriesPerMinute: (json['caloriesPerMinute'] as num).toDouble(),
      defaultDuration: json['defaultDuration'] as int,
      reps: json['reps'] as int?,
      sets: json['sets'] as int?,
      imagePath: json['imagePath'] as String?,
      videoUrl: json['videoUrl'] as String?,
      tips: json['tips'] != null ? List<String>.from(json['tips'] as List) : [],
      modifications: json['modifications'] != null
          ? List<String>.from(json['modifications'] as List)
          : [],
    );
  }

  get duration => null;

  // Copy with method
  ExerciseModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? targetAreas,
    String? category,
    String? difficulty,
    double? caloriesPerMinute,
    int? defaultDuration,
    int? reps,
    int? sets,
    String? imagePath,
    String? videoUrl,
    List<String>? tips,
    List<String>? modifications,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetAreas: targetAreas ?? this.targetAreas,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      caloriesPerMinute: caloriesPerMinute ?? this.caloriesPerMinute,
      defaultDuration: defaultDuration ?? this.defaultDuration,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
      imagePath: imagePath ?? this.imagePath,
      videoUrl: videoUrl ?? this.videoUrl,
      tips: tips ?? this.tips,
      modifications: modifications ?? this.modifications,
    );
  }

  @override
  String toString() {
    return 'ExerciseModel(id: $id, name: $name, category: $category, difficulty: $difficulty)';
  }
}
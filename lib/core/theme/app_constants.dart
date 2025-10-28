class AppConstants {
  // App Info
  static const String appName = 'AfroFit Wellness';
  static const String appVersion = '1.0.0';
  
  // Body Shape Options (FIXED during coding)
  static const List<Map<String, dynamic>> bodyShapeOptions = [
    {
      'id': 'hourglass',
      'name': 'Hourglass',
      'emoji': '⏳',
      'description': 'Enhance your natural curves',
      'focusAreas': ['core', 'glutes', 'arms'],
      'timeline': '8-12 weeks',
      'truthFact': 'Focus on building muscle in specific areas while maintaining overall fitness',
    },
    {
      'id': 'athletic',
      'name': 'Athletic/Toned',
      'emoji': '💪',
      'description': 'Build lean, defined muscles',
      'focusAreas': ['full_body', 'cardio'],
      'timeline': '10-16 weeks',
      'truthFact': 'Definition requires consistent training and proper nutrition',
    },
    {
      'id': 'slim',
      'name': 'Slim/Slender',
      'emoji': '🌿',
      'description': 'Achieve a lean physique',
      'focusAreas': ['cardio', 'light_toning'],
      'timeline': '6-12 weeks',
      'truthFact': 'Don\'t skip strength training - it helps maintain metabolism',
    },
    {
      'id': 'curvy',
      'name': 'Curvy/Thick',
      'emoji': '🍑',
      'description': 'Build curves in the right places',
      'focusAreas': ['glutes', 'legs', 'core'],
      'timeline': '12-16 weeks',
      'truthFact': 'Building muscle takes time and progressive overload',
    },
    {
      'id': 'reduce_pear',
      'name': 'Reduce Pear Shape',
      'emoji': '🍐',
      'description': 'Balance upper and lower body',
      'focusAreas': ['lower_body', 'full_body', 'cardio'],
      'timeline': '10-14 weeks',
      'truthFact': 'Genetics determine fat storage patterns - focus on overall fat loss',
    },
    {
      'id': 'reduce_apple',
      'name': 'Reduce Apple Shape',
      'emoji': '🍎',
      'description': 'Reduce midsection, tone overall',
      'focusAreas': ['core', 'upper_body', 'cardio'],
      'timeline': '8-12 weeks',
      'truthFact': 'Belly fat responds well to calorie deficit and consistent exercise',
    },
  ];
  
  // Problem Areas (FIXED during coding)
  static const List<Map<String, String>> problemAreas = [
    // Upper Body
    {'id': 'arm_flab', 'name': 'Arm Flab ("Bat Wings")', 'category': 'upper_body'},
    {'id': 'back_fat', 'name': 'Back Fat', 'category': 'upper_body'},
    {'id': 'bra_bulge', 'name': 'Bra Bulge', 'category': 'upper_body'},
    {'id': 'double_chin', 'name': 'Double Chin', 'category': 'upper_body'},
    
    // Core
    {'id': 'belly_fat_upper', 'name': 'Upper Belly Fat', 'category': 'core'},
    {'id': 'belly_fat_lower', 'name': 'Lower Belly Fat', 'category': 'core'},
    {'id': 'love_handles', 'name': 'Love Handles', 'category': 'core'},
    {'id': 'muffin_top', 'name': 'Muffin Top', 'category': 'core'},
    {'id': 'back_rolls', 'name': 'Back Rolls', 'category': 'core'},
    
    // Lower Body
    {'id': 'inner_thighs', 'name': 'Inner Thighs', 'category': 'lower_body'},
    {'id': 'outer_thighs', 'name': 'Outer Thighs (Saddlebags)', 'category': 'lower_body'},
    {'id': 'under_butt', 'name': 'Under-Butt Area', 'category': 'lower_body'},
    {'id': 'hip_dips', 'name': 'Hip Dips', 'category': 'lower_body'},
    {'id': 'cankles', 'name': 'Cankles', 'category': 'lower_body'},
  ];
  
  // Activity Levels (FIXED)
  static const Map<String, double> activityMultipliers = {
    'sedentary': 1.2,
    'lightly_active': 1.375,
    'moderately_active': 1.55,
    'very_active': 1.725,
  };
  
  static const List<Map<String, String>> activityLevelDescriptions = [
    {
      'id': 'sedentary',
      'title': 'Sedentary',
      'description': 'Little or no exercise, desk job',
    },
    {
      'id': 'lightly_active',
      'title': 'Lightly Active',
      'description': 'Light exercise 1-3 days/week',
    },
    {
      'id': 'moderately_active',
      'title': 'Moderately Active',
      'description': 'Moderate exercise 3-5 days/week',
    },
    {
      'id': 'very_active',
      'title': 'Very Active',
      'description': 'Hard exercise 6-7 days/week',
    },
  ];
  
  // Meal Types (FIXED)
  static const List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];
  
  // Water Tracking (FIXED)
  static const int defaultWaterGoalMl = 2000; // 2 liters
  static const int waterGlassSizeMl = 250; // 250ml per glass
  
  // Sleep Tracking (FIXED)
  static const int defaultSleepGoalHours = 8;
  
  // Weight Loss Constants (FIXED)
  static const double caloriesPerKgFat = 7700; // Calories in 1kg of fat
  static const double maxHealthyWeightLossPerWeek = 1.0; // kg
  static const double minHealthyWeightLossPerWeek = 0.5; // kg
  
  // BMI Categories (FIXED)
  static String getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
  
  // Default Workout Duration (FIXED)
  static const int defaultWorkoutDurationMinutes = 20;
  static const int minWorkoutDurationMinutes = 10;
  static const int maxWorkoutDurationMinutes = 60;
  
  // Exercise Rest Time (FIXED)
  static const int defaultRestSeconds = 30;
  static const int minRestSeconds = 15;
  static const int maxRestSeconds = 90;
  
  // Progress Check-in (FIXED)
  static const int progressCheckInDays = 7; // Weekly
  
  // Achievement Thresholds (FIXED)
  static const Map<String, int> achievementThresholds = {
    'first_workout': 1,
    'workout_streak_3': 3,
    'workout_streak_7': 7,
    'workout_streak_30': 30,
    'weight_loss_5kg': 5,
    'weight_loss_10kg': 10,
    'water_streak_7': 7,
    'perfect_week': 7,
  };
}
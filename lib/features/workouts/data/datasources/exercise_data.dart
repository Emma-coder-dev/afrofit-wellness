import '../models/exercise_model.dart';

class ExerciseData {
  // Complete Exercise Library (60+ exercises)
  static final List<ExerciseModel> allExercises = [
    // ==================== WARM-UP EXERCISES ====================
    ExerciseModel(
      id: 'warmup_001',
      name: 'Jumping Jacks',
      description: 'Stand with feet together and arms at sides. Jump while spreading legs shoulder-width apart and raising arms overhead. Return to starting position and repeat.',
      targetAreas: ['abs', 'obliques', 'core'],
      category: 'warmup',
      difficulty: 'intermediate',
      caloriesPerMinute: 6.0,
      defaultDuration: 60,
      reps: 20,
      tips: [
        'Rotate torso, not just elbows',
        'Fully extend each leg',
        'Keep lower back on ground',
      ],
    ),

    ExerciseModel(
      id: 'warmup_002',
      name: 'Arm Circles',
      description: 'Stand with feet shoulder-width apart. Extend arms straight out to sides at shoulder height. Make small forward circles, gradually increasing size. Reverse direction.',
      targetAreas: ['shoulders', 'arms'],
      category: 'warmup',
      difficulty: 'beginner',
      caloriesPerMinute: 3.0,
      defaultDuration: 60,
      tips: [
        'Keep arms straight and parallel to ground',
        'Start with small circles',
        'Maintain good posture',
      ],
    ),

    ExerciseModel(
      id: 'warmup_003',
      name: 'High Knees',
      description: 'Stand tall and run in place, bringing knees up to hip level with each step. Pump arms in running motion.',
      targetAreas: ['legs', 'cardio', 'core'],
      category: 'warmup',
      difficulty: 'beginner',
      caloriesPerMinute: 9.0,
      defaultDuration: 45,
      tips: [
        'Engage your core',
        'Land on balls of feet',
        'Keep chest up',
      ],
      modifications: [
        'Easier: March in place',
        'Harder: Speed up the pace',
      ],
    ),

    ExerciseModel(
      id: 'warmup_004',
      name: 'Leg Swings',
      description: 'Hold onto a wall for balance. Swing one leg forward and backward in a controlled motion. Switch legs after completing reps.',
      targetAreas: ['legs', 'hips'],
      category: 'warmup',
      difficulty: 'beginner',
      caloriesPerMinute: 3.5,
      defaultDuration: 60,
      reps: 15,
    ),

    // ==================== CORE EXERCISES ====================
    ExerciseModel(
      id: 'core_001',
      name: 'Plank',
      description: 'Start in push-up position. Lower onto forearms, keeping elbows directly under shoulders. Keep body in straight line from head to heels. Hold position.',
      targetAreas: ['core', 'abs', 'shoulders'],
      category: 'core',
      difficulty: 'beginner',
      caloriesPerMinute: 4.0,
      defaultDuration: 30,
      tips: [
        'Don\'t let hips sag or pike up',
        'Engage your core muscles',
        'Look at the floor to keep neck neutral',
        'Breathe steadily',
      ],
      modifications: [
        'Easier: Do on knees',
        'Harder: Lift one leg at a time',
      ],
    ),

    ExerciseModel(
      id: 'core_002',
      name: 'Crunches',
      description: 'Lie on back with knees bent and feet flat. Place hands behind head. Lift shoulders off the ground by contracting abs. Lower back down with control.',
      targetAreas: ['abs', 'core'],
      category: 'core',
      difficulty: 'beginner',
      caloriesPerMinute: 5.0,
      defaultDuration: 60,
      reps: 15,
      tips: [
        'Don\'t pull on your neck',
        'Focus on using abs, not momentum',
        'Keep lower back pressed to floor',
      ],
    ),

    ExerciseModel(
      id: 'core_003',
      name: 'Bicycle Crunches',
      description: 'Lie on back, hands behind head. Lift shoulders and bring right elbow to left knee while extending right leg. Alternate sides in pedaling motion.',
      targetAreas: ['abs', 'obliques', 'core'],
      category: 'core',
      difficulty: 'intermediate',
      caloriesPerMinute: 5.5,
      defaultDuration: 60,
      reps: 20,
      tips: [
        'Rotate torso, not just elbows',
        'Fully extend each leg',
        'Keep lower back on ground',
      ],
    ),

    ExerciseModel(
      id: 'core_004',
      name: 'Russian Twists',
      description: 'Sit on floor, lean back slightly, lift feet off ground. Hold hands together at chest. Rotate torso to touch hands to floor on each side.',
      targetAreas: ['obliques', 'core', 'abs'],
      category: 'core',
      difficulty: 'intermediate',
      caloriesPerMinute: 5.5,
      defaultDuration: 60,
      reps: 20,
      tips: [
        'Keep core engaged',
        'Move with control',
        'Keep chest up',
      ],
      modifications: [
        'Easier: Keep feet on ground',
        'Harder: Hold a water bottle',
      ],
    ),

    ExerciseModel(
      id: 'core_005',
      name: 'Leg Raises',
      description: 'Lie flat on back, hands under hips for support. Keep legs straight and lift them to 90 degrees. Lower slowly without touching the floor.',
      targetAreas: ['lower_abs', 'core'],
      category: 'core',
      difficulty: 'intermediate',
      caloriesPerMinute: 5.0,
      defaultDuration: 60,
      reps: 12,
      tips: [
        'Press lower back into floor',
        'Lower legs slowly',
        'Don\'t swing legs',
      ],
    ),

    ExerciseModel(
      id: 'core_006',
      name: 'Mountain Climbers',
      description: 'Start in plank position. Drive right knee toward chest, then quickly switch legs, bringing left knee forward while right leg goes back. Continue alternating rapidly.',
      targetAreas: ['core', 'cardio', 'shoulders'],
      category: 'core',
      difficulty: 'intermediate',
      caloriesPerMinute: 10.0,
      defaultDuration: 45,
      tips: [
        'Keep hips level',
        'Maintain plank position',
        'Move as fast as you can with control',
      ],
    ),

    ExerciseModel(
      id: 'core_007',
      name: 'Flutter Kicks',
      description: 'Lie on back, hands under hips. Lift both legs slightly off ground. Alternate kicking legs up and down in small, rapid movements.',
      targetAreas: ['lower_abs', 'core'],
      category: 'core',
      difficulty: 'intermediate',
      caloriesPerMinute: 5.5,
      defaultDuration: 45,
      tips: [
        'Keep legs straight',
        'Small, controlled movements',
        'Press lower back to floor',
      ],
    ),

    // ==================== UPPER BODY EXERCISES ====================
    ExerciseModel(
      id: 'upper_001',
      name: 'Push-ups',
      description: 'Start in plank position with hands slightly wider than shoulders. Lower body until chest nearly touches floor. Push back up to starting position.',
      targetAreas: ['chest', 'arms', 'shoulders', 'core'],
      category: 'upper_body',
      difficulty: 'intermediate',
      caloriesPerMinute: 7.0,
      defaultDuration: 60,
      reps: 12,
      tips: [
        'Keep body in straight line',
        'Lower yourself with control',
        'Keep elbows at 45-degree angle',
      ],
      modifications: [
        'Easier: Do on knees or against wall',
        'Harder: Elevate feet',
      ],
    ),

    ExerciseModel(
      id: 'upper_002',
      name: 'Tricep Dips',
      description: 'Sit on edge of chair, hands gripping edge beside hips. Slide hips forward off chair. Bend elbows to lower body toward floor. Push back up.',
      targetAreas: ['triceps', 'arms', 'shoulders'],
      category: 'upper_body',
      difficulty: 'beginner',
      caloriesPerMinute: 6.0,
      defaultDuration: 60,
      reps: 12,
      tips: [
        'Keep elbows pointing back',
        'Don\'t let shoulders shrug up',
        'Lower until elbows at 90 degrees',
      ],
    ),

    ExerciseModel(
      id: 'upper_003',
      name: 'Diamond Push-ups',
      description: 'Get in push-up position with hands close together, forming diamond shape with thumbs and index fingers. Perform push-up.',
      targetAreas: ['triceps', 'chest', 'arms'],
      category: 'upper_body',
      difficulty: 'advanced',
      caloriesPerMinute: 8.0,
      defaultDuration: 60,
      reps: 10,
      tips: [
        'Keep elbows close to body',
        'Maintain straight body line',
      ],
      modifications: [
        'Easier: Do on knees',
      ],
    ),

    ExerciseModel(
      id: 'upper_004',
      name: 'Wide Push-ups',
      description: 'Start in push-up position with hands wider than shoulder-width. Lower chest to ground and push back up.',
      targetAreas: ['chest', 'shoulders'],
      category: 'upper_body',
      difficulty: 'intermediate',
      caloriesPerMinute: 7.5,
      defaultDuration: 60,
      reps: 12,
    ),

    ExerciseModel(
      id: 'upper_005',
      name: 'Arm Circles (Intensive)',
      description: 'Extend arms straight out to sides. Make small circles for 30 seconds forward, then 30 seconds backward. Keep tension in arms throughout.',
      targetAreas: ['shoulders', 'arms'],
      category: 'upper_body',
      difficulty: 'beginner',
      caloriesPerMinute: 4.0,
      defaultDuration: 60,
      tips: [
        'Keep arms straight',
        'Don\'t drop arms',
        'Engage shoulders',
      ],
    ),

    ExerciseModel(
      id: 'upper_006',
      name: 'Shoulder Taps',
      description: 'Get in plank position. Lift right hand to tap left shoulder, then return. Repeat with left hand to right shoulder. Keep hips stable.',
      targetAreas: ['shoulders', 'core', 'arms'],
      category: 'upper_body',
      difficulty: 'intermediate',
      caloriesPerMinute: 5.0,
      defaultDuration: 60,
      reps: 20,
      tips: [
        'Keep hips from rocking',
        'Maintain plank position',
        'Move with control',
      ],
    ),

    // ==================== LOWER BODY EXERCISES ====================
    ExerciseModel(
      id: 'lower_001',
      name: 'Squats',
      description: 'Stand with feet shoulder-width apart. Lower hips back and down as if sitting in chair. Keep chest up and knees behind toes. Push through heels to stand.',
      targetAreas: ['glutes', 'thighs', 'quads', 'legs'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 7.0,
      defaultDuration: 60,
      reps: 15,
      tips: [
        'Keep weight in heels',
        'Push knees out',
        'Go as low as comfortable',
        'Keep chest up',
      ],
      modifications: [
        'Easier: Hold onto chair for support',
        'Harder: Hold at bottom for 3 seconds',
      ],
    ),

    ExerciseModel(
      id: 'lower_002',
      name: 'Lunges',
      description: 'Stand tall. Step forward with right leg, lowering hips until both knees bent at 90 degrees. Push back to starting position. Alternate legs.',
      targetAreas: ['glutes', 'thighs', 'quads'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 6.5,
      defaultDuration: 60,
      reps: 12,
      tips: [
        'Keep front knee over ankle',
        'Don\'t let front knee go past toes',
        'Keep torso upright',
      ],
    ),

    ExerciseModel(
      id: 'lower_003',
      name: 'Glute Bridges',
      description: 'Lie on back with knees bent, feet flat on floor hip-width apart. Lift hips toward ceiling, squeezing glutes at top. Lower back down with control.',
      targetAreas: ['glutes', 'hamstrings', 'core'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 5.0,
      defaultDuration: 60,
      reps: 15,
      tips: [
        'Squeeze glutes at top',
        'Don\'t arch lower back',
        'Keep core engaged',
      ],
      modifications: [
        'Harder: Single leg bridges',
        'Harder: Hold at top for 5 seconds',
      ],
    ),

    ExerciseModel(
      id: 'lower_004',
      name: 'Donkey Kicks',
      description: 'Start on hands and knees. Keeping right knee bent at 90 degrees, lift right leg toward ceiling, squeezing glute. Lower and repeat. Switch legs.',
      targetAreas: ['glutes', 'hamstrings'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 4.5,
      defaultDuration: 60,
      reps: 15,
      tips: [
        'Keep knee bent',
        'Squeeze glute at top',
        'Don\'t arch lower back',
      ],
    ),

    ExerciseModel(
      id: 'lower_005',
      name: 'Sumo Squats',
      description: 'Stand with feet wider than shoulder-width, toes pointed out. Lower into squat, keeping knees in line with toes. Push through heels to stand.',
      targetAreas: ['inner_thighs', 'glutes', 'quads'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 6.5,
      defaultDuration: 60,
      reps: 15,
      tips: [
        'Point toes outward',
        'Keep chest up',
        'Push knees out',
      ],
    ),

    ExerciseModel(
      id: 'lower_006',
      name: 'Calf Raises',
      description: 'Stand with feet hip-width apart. Rise up onto balls of feet, lifting heels as high as possible. Lower back down with control.',
      targetAreas: ['calves', 'legs'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 4.0,
      defaultDuration: 60,
      reps: 20,
      tips: [
        'Hold at top for 1 second',
        'Lower slowly',
        'Keep ankles stable',
      ],
      modifications: [
        'Easier: Hold onto wall',
        'Harder: Single leg calf raises',
      ],
    ),

    ExerciseModel(
      id: 'lower_007',
      name: 'Wall Sit',
      description: 'Stand with back against wall. Slide down until thighs parallel to ground, knees at 90 degrees. Hold position.',
      targetAreas: ['quads', 'thighs', 'glutes'],
      category: 'lower_body',
      difficulty: 'intermediate',
      caloriesPerMinute: 5.5,
      defaultDuration: 45,
      tips: [
        'Keep back flat against wall',
        'Knees at 90 degrees',
        'Don\'t let knees go past toes',
      ],
    ),

    ExerciseModel(
      id: 'lower_008',
      name: 'Side Lunges',
      description: 'Stand with feet together. Step right leg out to side, bending right knee while keeping left leg straight. Push back to center. Alternate sides.',
      targetAreas: ['inner_thighs', 'outer_thighs', 'glutes'],
      category: 'lower_body',
      difficulty: 'intermediate',
      caloriesPerMinute: 6.0,
      defaultDuration: 60,
      reps: 12,
      tips: [
        'Keep toes pointed forward',
        'Push hips back',
        'Keep chest up',
      ],
    ),

    ExerciseModel(
      id: 'lower_009',
      name: 'Fire Hydrants',
      description: 'Start on hands and knees. Keeping right knee bent, lift right leg out to side. Lower and repeat. Switch legs.',
      targetAreas: ['outer_thighs', 'hips', 'glutes'],
      category: 'lower_body',
      difficulty: 'beginner',
      caloriesPerMinute: 4.0,
      defaultDuration: 60,
      reps: 15,
      tips: [
        'Keep hips level',
        'Don\'t rotate torso',
        'Squeeze glute',
      ],
    ),

    ExerciseModel(
      id: 'lower_010',
      name: 'Squat Pulses',
      description: 'Get into squat position. Instead of standing up, pulse up and down in small movements, staying in squat position.',
      targetAreas: ['quads', 'glutes', 'thighs'],
      category: 'lower_body',
      difficulty: 'intermediate',
      caloriesPerMinute: 7.5,
      defaultDuration: 45,
      tips: [
        'Stay low',
        'Small, quick movements',
        'Keep core engaged',
      ],
    ),

    // ==================== CARDIO EXERCISES ====================
    ExerciseModel(
      id: 'cardio_001',
      name: 'Burpees',
      description: 'Start standing. Drop into squat, place hands on floor. Jump feet back to plank. Do push-up. Jump feet back to hands. Jump up explosively.',
      targetAreas: ['full_body', 'cardio'],
      category: 'cardio',
      difficulty: 'advanced',
      caloriesPerMinute: 12.0,
      defaultDuration: 45,
      reps: 10,
      tips: [
        'Land softly',
        'Maintain plank position',
        'Pace yourself',
      ],
      modifications: [
        'Easier: Skip the push-up',
        'Easier: Step back instead of jumping',
      ],
    ),

    ExerciseModel(
      id: 'cardio_002',
      name: 'Butt Kicks',
      description: 'Run in place, kicking heels up to touch your glutes with each step. Pump arms.',
      targetAreas: ['legs', 'cardio', 'hamstrings'],
      category: 'cardio',
      difficulty: 'beginner',
      caloriesPerMinute: 8.0,
      defaultDuration: 45,
      tips: [
        'Kick heels high',
        'Stay on balls of feet',
        'Keep chest up',
      ],
    ),

    ExerciseModel(
      id: 'cardio_003',
      name: 'Jump Rope (Simulated)',
      description: 'Jump with both feet together while rotating wrists as if holding jump rope. Land softly on balls of feet.',
      targetAreas: ['calves', 'cardio', 'legs'],
      category: 'cardio',
      difficulty: 'beginner',
      caloriesPerMinute: 10.0,
      defaultDuration: 60,
      tips: [
        'Land softly',
        'Stay on balls of feet',
        'Keep jumps small',
      ],
    ),

    ExerciseModel(
      id: 'cardio_004',
      name: 'Skaters',
      description: 'Leap side to side, landing on one foot while sweeping other foot behind. Alternate sides in skating motion.',
      targetAreas: ['legs', 'cardio', 'glutes'],
      category: 'cardio',
      difficulty: 'intermediate',
      caloriesPerMinute: 9.0,
      defaultDuration: 45,
      tips: [
        'Land softly',
        'Push off powerfully',
        'Keep chest up',
      ],
    ),

    ExerciseModel(
      id: 'cardio_005',
      name: 'Star Jumps',
      description: 'Start in squat position. Jump up explosively, extending arms and legs out to form star shape. Land back in squat.',
      targetAreas: ['full_body', 'cardio'],
      category: 'cardio',
      difficulty: 'intermediate',
      caloriesPerMinute: 11.0,
      defaultDuration: 45,
      reps: 12,
      tips: [
        'Explode upward',
        'Extend fully',
        'Land softly in squat',
      ],
    ),

    // ==================== COOL-DOWN EXERCISES ====================
    ExerciseModel(
      id: 'cooldown_001',
      name: 'Hamstring Stretch',
      description: 'Sit with right leg extended, left knee bent. Reach toward right toes, keeping back straight. Hold. Switch legs.',
      targetAreas: ['hamstrings', 'legs'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 2.0,
      defaultDuration: 30,
      tips: [
        'Don\'t bounce',
        'Keep back straight',
        'Breathe deeply',
      ],
    ),

    ExerciseModel(
      id: 'cooldown_002',
      name: 'Quad Stretch',
      description: 'Stand on left leg. Bend right knee, bringing heel toward glute. Hold right ankle with right hand. Hold. Switch legs.',
      targetAreas: ['quads', 'thighs'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 2.0,
      defaultDuration: 30,
      tips: [
        'Keep knees together',
        'Don\'t arch back',
        'Hold onto wall if needed',
      ],
    ),

    ExerciseModel(
      id: 'cooldown_003',
      name: 'Child\'s Pose',
      description: 'Kneel on floor, sit back on heels. Extend arms forward and lower chest toward floor. Rest forehead on ground. Breathe deeply.',
      targetAreas: ['back', 'hips', 'shoulders'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 1.5,
      defaultDuration: 60,
      tips: [
        'Relax completely',
        'Breathe deeply',
        'Let tension melt away',
      ],
    ),

    ExerciseModel(
      id: 'cooldown_004',
      name: 'Cat-Cow Stretch',
      description: 'Start on hands and knees. Arch back while lifting head (cow). Round back while tucking chin (cat). Flow between positions.',
      targetAreas: ['back', 'core', 'spine'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 2.5,
      defaultDuration: 60,
      tips: [
        'Move slowly',
        'Breathe with movement',
        'Feel the stretch in spine',
      ],
    ),

    ExerciseModel(
      id: 'cooldown_005',
      name: 'Hip Flexor Stretch',
      description: 'Kneel on right knee, left foot forward. Push hips forward gently, feeling stretch in right hip flexor. Hold. Switch sides.',
      targetAreas: ['hip_flexors', 'hips'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 2.0,
      defaultDuration: 30,
      tips: [
        'Keep torso upright',
        'Don\'t arch back excessively',
        'Feel stretch in front of hip',
      ],
    ),

    ExerciseModel(
      id: 'cooldown_006',
      name: 'Shoulder Stretch',
      description: 'Bring right arm across chest. Use left hand to gently pull right arm closer. Hold. Switch arms.',
      targetAreas: ['shoulders', 'arms'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 1.5,
      defaultDuration: 30,
      tips: [
        'Don\'t shrug shoulders',
        'Keep arm straight',
        'Gentle pressure only',
      ],
    ),

    ExerciseModel(
      id: 'cooldown_007',
      name: 'Tricep Stretch',
      description: 'Raise right arm overhead. Bend elbow, bringing right hand to upper back. Use left hand to gently push right elbow. Hold. Switch arms.',
      targetAreas: ['triceps', 'shoulders'],
      category: 'cooldown',
      difficulty: 'beginner',
      caloriesPerMinute: 1.5,
      defaultDuration: 30,
      tips: [
        'Keep elbow pointing up',
        'Don\'t force the stretch',
        'Breathe deeply',
      ],
    ),
  ];

  // ==================== HELPER METHODS ====================

  // Get all exercises
  static List<ExerciseModel> getAllExercises() => allExercises;

  // Get exercises by category
  static List<ExerciseModel> getExercisesByCategory(String category) {
    return allExercises.where((exercise) => exercise.category == category).toList();
  }

  // Get exercises by difficulty
  static List<ExerciseModel> getExercisesByDifficulty(String difficulty) {
    return allExercises.where((exercise) => exercise.difficulty == difficulty).toList();
  }

  // Get exercises that target specific area
  static List<ExerciseModel> getExercisesByTargetArea(String targetArea) {
    return allExercises.where((exercise) => 
      exercise.targetAreas.contains(targetArea)
    ).toList();
  }

  // Get exercise by ID
  static ExerciseModel? getExerciseById(String id) {
    try {
      return allExercises.firstWhere((exercise) => exercise.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search exercises by name
  static List<ExerciseModel> searchExercises(String query) {
    final lowerQuery = query.toLowerCase();
    return allExercises.where((exercise) => 
      exercise.name.toLowerCase().contains(lowerQuery) ||
      exercise.description.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  // Get workout plan based on body shape and problem areas
  static List<ExerciseModel> getPersonalizedWorkout({
    required String bodyShape,
    required List<String> problemAreas,
    int? duration,
  }) {
    List<ExerciseModel> workout = [];

    // Add warm-up (always include)
    workout.addAll(getExercisesByCategory('warmup').take(2));

    // Add exercises based on body shape goal
    switch (bodyShape) {
      case 'hourglass':
        workout.addAll(getExercisesByTargetArea('core').take(3));
        workout.addAll(getExercisesByTargetArea('glutes').take(3));
        workout.addAll(getExercisesByTargetArea('arms').take(2));
        break;
      
      case 'athletic':
        workout.addAll(getExercisesByCategory('upper_body').take(3));
        workout.addAll(getExercisesByCategory('lower_body').take(3));
        workout.addAll(getExercisesByCategory('cardio').take(2));
        break;
      
      case 'slim':
        workout.addAll(getExercisesByCategory('cardio').take(4));
        workout.addAll(getExercisesByTargetArea('core').take(2));
        workout.addAll(getExercisesByCategory('lower_body').take(2));
        break;
      
      case 'curvy':
        workout.addAll(getExercisesByTargetArea('glutes').take(4));
        workout.addAll(getExercisesByTargetArea('thighs').take(3));
        workout.addAll(getExercisesByTargetArea('core').take(2));
        break;
      
      case 'reduce_pear':
        workout.addAll(getExercisesByTargetArea('legs').take(4));
        workout.addAll(getExercisesByCategory('cardio').take(3));
        workout.addAll(getExercisesByTargetArea('core').take(2));
        break;
      
      case 'reduce_apple':
        workout.addAll(getExercisesByTargetArea('core').take(4));
        workout.addAll(getExercisesByCategory('cardio').take(3));
        workout.addAll(getExercisesByCategory('upper_body').take(2));
        break;
      
      default:
        // Default full body workout
        workout.addAll(getExercisesByCategory('upper_body').take(3));
        workout.addAll(getExercisesByCategory('lower_body').take(3));
        workout.addAll(getExercisesByCategory('core').take(2));
    }

    // Add exercises for specific problem areas
    for (String problemArea in problemAreas) {
      switch (problemArea) {
        case 'belly_fat_upper':
        case 'belly_fat_lower':
          workout.addAll(getExercisesByTargetArea('abs').take(2));
          break;
        case 'love_handles':
        case 'muffin_top':
          workout.addAll(getExercisesByTargetArea('obliques').take(2));
          break;
        case 'arm_flab':
          workout.addAll(getExercisesByTargetArea('triceps').take(2));
          break;
        case 'inner_thighs':
          workout.addAll(getExercisesByTargetArea('inner_thighs').take(2));
          break;
        case 'outer_thighs':
          workout.addAll(getExercisesByTargetArea('outer_thighs').take(2));
          break;
      }
    }

    // Add cool-down (always include)
    workout.addAll(getExercisesByCategory('cooldown').take(3));

    // Remove duplicates
    final uniqueWorkout = workout.toSet().toList();

    return uniqueWorkout;
  }

  // Get beginner-friendly workout
  static List<ExerciseModel> getBeginnerWorkout() {
    return [
      ...getExercisesByCategory('warmup').take(2),
      ...getExercisesByDifficulty('beginner').where((e) => e.category != 'warmup' && e.category != 'cooldown').take(8),
      ...getExercisesByCategory('cooldown').take(2),
    ];
  }

  // Get quick 10-minute workout
  static List<ExerciseModel> getQuickWorkout() {
    return [
      ...getExercisesByCategory('warmup').take(1),
      ...getExercisesByCategory('cardio').take(2),
      ...getExercisesByCategory('core').take(2),
      ...getExercisesByCategory('lower_body').take(2),
      ...getExercisesByCategory('cooldown').take(1),
    ];
  }

  // Get personalized workout plan based on body shape and problem areas
  static List<ExerciseModel> getWorkoutPlan(String bodyShape, List<String> problemAreas) {
    List<ExerciseModel> recommendedExercises = [];

    // Add warm-up exercises
    recommendedExercises.addAll(
      allExercises.where((ex) => ex.category == 'warmup').take(2).toList(),
    );

    // Add exercises based on body shape goal
    switch (bodyShape) {
      case 'hourglass':
        // Focus on core and glutes
        recommendedExercises.addAll(
          allExercises.where((ex) => 
            ex.targetAreas.contains('core') || 
            ex.targetAreas.contains('glutes')
          ).take(4).toList(),
        );
        break;
      
      case 'athletic':
        // Full body focus
        recommendedExercises.addAll(
          allExercises.where((ex) => 
            ex.category == 'upper_body' || 
            ex.category == 'lower_body'
          ).take(4).toList(),
        );
        break;
      
      case 'slim':
        // Cardio and light toning
        recommendedExercises.addAll(
          allExercises.where((ex) => ex.category == 'cardio').take(4).toList(),
        );
        break;
      
      case 'curvy':
        // Glutes and legs
        recommendedExercises.addAll(
          allExercises.where((ex) => 
            ex.targetAreas.contains('glutes') || 
            ex.targetAreas.contains('thighs')
          ).take(4).toList(),
        );
        break;
      
      case 'pear':
        // Lower body focus
        recommendedExercises.addAll(
          allExercises.where((ex) => ex.category == 'lower_body').take(4).toList(),
        );
        break;
      
      case 'apple':
        // Core focus
        recommendedExercises.addAll(
          allExercises.where((ex) => 
            ex.targetAreas.contains('core') || 
            ex.targetAreas.contains('abs')
          ).take(4).toList(),
        );
        break;
      
      default:
        // Default: balanced workout
        recommendedExercises.addAll(allExercises.take(6).toList());
    }

    // Add exercises for problem areas
    for (String problemArea in problemAreas) {
      switch (problemArea) {
        case 'belly_fat':
        case 'love_handles':
        case 'muffin_top':
          recommendedExercises.addAll(
            allExercises.where((ex) => 
              ex.targetAreas.contains('core') || 
              ex.targetAreas.contains('abs') ||
              ex.targetAreas.contains('obliques')
            ).take(2).toList(),
          );
          break;
        
        case 'arm_flab':
        case 'back_fat':
          recommendedExercises.addAll(
            allExercises.where((ex) => 
              ex.targetAreas.contains('arms') || 
              ex.targetAreas.contains('shoulders')
            ).take(2).toList(),
          );
          break;
        
        case 'inner_thighs':
        case 'outer_thighs':
        case 'under_butt':
          recommendedExercises.addAll(
            allExercises.where((ex) => 
              ex.targetAreas.contains('thighs') || 
              ex.targetAreas.contains('glutes')
            ).take(2).toList(),
          );
          break;
      }
    }

    // Add cool-down exercises
    recommendedExercises.addAll(
      allExercises.where((ex) => ex.category == 'cooldown').take(2).toList(),
    );

    // Remove duplicates and return
    return recommendedExercises.toSet().toList();
  }
}
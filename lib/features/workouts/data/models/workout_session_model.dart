import 'package:hive/hive.dart';

part 'workout_session_model.g.dart'; // For Hive code generation

@HiveType(typeId: 2)
class WorkoutSessionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String workoutPlanId; // Reference to workout plan

  @HiveField(3)
  final String workoutName; // e.g., "Full Body Blast", "Glute Focus"

  @HiveField(4)
  final List<String> exerciseIds; // List of exercise IDs performed

  @HiveField(5)
  final DateTime startTime;

  @HiveField(6)
  final DateTime? endTime;

  @HiveField(7)
  final int totalDurationSeconds; // Actual workout duration

  @HiveField(8)
  final int caloriesBurned; // Estimated calories burned

  @HiveField(9)
  final bool completed; // Did user finish the workout?

  @HiveField(10)
  final double completionPercentage; // % of exercises completed

  @HiveField(11)
  final Map<String, dynamic>? exerciseData; // Detailed exercise data (reps, sets, etc.)

  @HiveField(12)
  final String? notes; // User notes about the workout

  @HiveField(13)
  final int? rating; // User rating 1-5

  WorkoutSessionModel({
    required this.id,
    required this.userId,
    required this.workoutPlanId,
    required this.workoutName,
    required this.exerciseIds,
    required this.startTime,
    this.endTime,
    required this.totalDurationSeconds,
    required this.caloriesBurned,
    required this.completed,
    required this.completionPercentage,
    this.exerciseData,
    this.notes,
    this.rating,
  });

  // Get duration in minutes
  int get durationMinutes => totalDurationSeconds ~/ 60;

  // Get formatted duration
  String get formattedDuration {
    final minutes = totalDurationSeconds ~/ 60;
    final seconds = totalDurationSeconds % 60;
    if (minutes > 0 && seconds > 0) {
      return '${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${seconds}s';
    }
  }

  // Get date string
  String get dateString {
    final now = DateTime.now();
    final difference = now.difference(startTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${startTime.day}/${startTime.month}/${startTime.year}';
    }
  }

  // Check if workout is in progress
  bool get isInProgress => endTime == null && !completed;

  // Get completion status text
  String get completionStatus {
    if (completed) return 'Completed';
    if (isInProgress) return 'In Progress';
    return 'Incomplete';
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'workoutPlanId': workoutPlanId,
      'workoutName': workoutName,
      'exerciseIds': exerciseIds,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'totalDurationSeconds': totalDurationSeconds,
      'caloriesBurned': caloriesBurned,
      'completed': completed,
      'completionPercentage': completionPercentage,
      'exerciseData': exerciseData,
      'notes': notes,
      'rating': rating,
    };
  }

  // Create from JSON
  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      workoutPlanId: json['workoutPlanId'] as String,
      workoutName: json['workoutName'] as String,
      exerciseIds: List<String>.from(json['exerciseIds'] as List),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      totalDurationSeconds: json['totalDurationSeconds'] as int,
      caloriesBurned: json['caloriesBurned'] as int,
      completed: json['completed'] as bool,
      completionPercentage: (json['completionPercentage'] as num).toDouble(),
      exerciseData: json['exerciseData'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
      rating: json['rating'] as int?,
    );
  }

  // Copy with method
  WorkoutSessionModel copyWith({
    String? id,
    String? userId,
    String? workoutPlanId,
    String? workoutName,
    List<String>? exerciseIds,
    DateTime? startTime,
    DateTime? endTime,
    int? totalDurationSeconds,
    int? caloriesBurned,
    bool? completed,
    double? completionPercentage,
    Map<String, dynamic>? exerciseData,
    String? notes,
    int? rating,
  }) {
    return WorkoutSessionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      workoutName: workoutName ?? this.workoutName,
      exerciseIds: exerciseIds ?? this.exerciseIds,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      completed: completed ?? this.completed,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      exerciseData: exerciseData ?? this.exerciseData,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() {
    return 'WorkoutSessionModel(id: $id, workoutName: $workoutName, duration: $formattedDuration, completed: $completed)';
  }
}
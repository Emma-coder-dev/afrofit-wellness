import 'package:hive/hive.dart';

part 'progress_model.g.dart'; // For Hive code generation

@HiveType(typeId: 3)
class ProgressModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final double weight; // kg

  @HiveField(4)
  final Map<String, double>? measurements; // Body measurements in cm

  @HiveField(5)
  final String? photoPath; // Path to progress photo

  @HiveField(6)
  final String? notes; // User notes

  @HiveField(7)
  final double? bmi;

  ProgressModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.weight,
    this.measurements,
    this.photoPath,
    this.notes,
    this.bmi,
  });

  // Standard body measurements
  static const List<String> standardMeasurements = [
    'neck',
    'shoulders',
    'chest',
    'waist',
    'hips',
    'thighs',
    'arms',
    'calves',
  ];

  // Get measurement value by name
  double? getMeasurement(String name) {
    return measurements?[name];
  }

  // Get formatted date
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'weight': weight,
      'measurements': measurements,
      'photoPath': photoPath,
      'notes': notes,
      'bmi': bmi,
    };
  }

  // Create from JSON
  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num).toDouble(),
      measurements: json['measurements'] != null
          ? Map<String, double>.from(json['measurements'] as Map)
          : null,
      photoPath: json['photoPath'] as String?,
      notes: json['notes'] as String?,
      bmi: (json['bmi'] as num?)?.toDouble(),
    );
  }

  // Copy with method
  ProgressModel copyWith({
    String? id,
    String? userId,
    DateTime? date,
    double? weight,
    Map<String, double>? measurements,
    String? photoPath,
    String? notes,
    double? bmi,
  }) {
    return ProgressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      measurements: measurements ?? this.measurements,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      bmi: bmi ?? this.bmi,
    );
  }

  @override
  String toString() {
    return 'ProgressModel(id: $id, date: $formattedDate, weight: $weight)';
  }
}
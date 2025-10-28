// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutSessionModelAdapter extends TypeAdapter<WorkoutSessionModel> {
  @override
  final int typeId = 2;

  @override
  WorkoutSessionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutSessionModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      workoutPlanId: fields[2] as String,
      workoutName: fields[3] as String,
      exerciseIds: (fields[4] as List).cast<String>(),
      startTime: fields[5] as DateTime,
      endTime: fields[6] as DateTime?,
      totalDurationSeconds: fields[7] as int,
      caloriesBurned: fields[8] as int,
      completed: fields[9] as bool,
      completionPercentage: fields[10] as double,
      exerciseData: (fields[11] as Map?)?.cast<String, dynamic>(),
      notes: fields[12] as String?,
      rating: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutSessionModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.workoutPlanId)
      ..writeByte(3)
      ..write(obj.workoutName)
      ..writeByte(4)
      ..write(obj.exerciseIds)
      ..writeByte(5)
      ..write(obj.startTime)
      ..writeByte(6)
      ..write(obj.endTime)
      ..writeByte(7)
      ..write(obj.totalDurationSeconds)
      ..writeByte(8)
      ..write(obj.caloriesBurned)
      ..writeByte(9)
      ..write(obj.completed)
      ..writeByte(10)
      ..write(obj.completionPercentage)
      ..writeByte(11)
      ..write(obj.exerciseData)
      ..writeByte(12)
      ..write(obj.notes)
      ..writeByte(13)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSessionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyLogModelAdapter extends TypeAdapter<DailyLogModel> {
  @override
  final int typeId = 4;

  @override
  DailyLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyLogModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      date: fields[2] as DateTime,
      caloriesConsumed: fields[3] as double,
      proteinConsumed: fields[4] as double,
      carbsConsumed: fields[5] as double,
      fatsConsumed: fields[6] as double,
      waterConsumedMl: fields[7] as int,
      workoutCompleted: fields[8] as bool,
      workoutDurationMinutes: fields[9] as int,
      caloriesBurned: fields[10] as int,
      sleepHours: fields[11] as double?,
      sleepQuality: fields[12] as int?,
      steps: fields[13] as int,
      mood: fields[14] as String?,
      notes: (fields[15] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyLogModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.caloriesConsumed)
      ..writeByte(4)
      ..write(obj.proteinConsumed)
      ..writeByte(5)
      ..write(obj.carbsConsumed)
      ..writeByte(6)
      ..write(obj.fatsConsumed)
      ..writeByte(7)
      ..write(obj.waterConsumedMl)
      ..writeByte(8)
      ..write(obj.workoutCompleted)
      ..writeByte(9)
      ..write(obj.workoutDurationMinutes)
      ..writeByte(10)
      ..write(obj.caloriesBurned)
      ..writeByte(11)
      ..write(obj.sleepHours)
      ..writeByte(12)
      ..write(obj.sleepQuality)
      ..writeByte(13)
      ..write(obj.steps)
      ..writeByte(14)
      ..write(obj.mood)
      ..writeByte(15)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

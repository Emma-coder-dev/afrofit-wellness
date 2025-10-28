// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressModelAdapter extends TypeAdapter<ProgressModel> {
  @override
  final int typeId = 3;

  @override
  ProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      date: fields[2] as DateTime,
      weight: fields[3] as double,
      measurements: (fields[4] as Map?)?.cast<String, double>(),
      photoPath: fields[5] as String?,
      notes: fields[6] as String?,
      bmi: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.measurements)
      ..writeByte(5)
      ..write(obj.photoPath)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.bmi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

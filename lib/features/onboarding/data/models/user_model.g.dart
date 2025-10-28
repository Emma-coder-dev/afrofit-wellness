// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      age: fields[2] as int,
      currentWeight: fields[3] as double,
      targetWeight: fields[4] as double,
      height: fields[5] as double,
      gender: fields[6] as String,
      activityLevel: fields[7] as String,
      desiredBodyShape: fields[8] as String,
      problemAreas: (fields[9] as List).cast<String>(),
      createdAt: fields[10] as DateTime,
      lastUpdated: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.currentWeight)
      ..writeByte(4)
      ..write(obj.targetWeight)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.activityLevel)
      ..writeByte(8)
      ..write(obj.desiredBodyShape)
      ..writeByte(9)
      ..write(obj.problemAreas)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

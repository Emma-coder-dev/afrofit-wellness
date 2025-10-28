// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealModelAdapter extends TypeAdapter<MealModel> {
  @override
  final int typeId = 1;

  @override
  MealModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      foodId: fields[2] as String,
      foodName: fields[3] as String,
      servings: fields[4] as double,
      mealType: fields[5] as String,
      timestamp: fields[6] as DateTime,
      calories: fields[7] as double,
      protein: fields[8] as double,
      carbs: fields[9] as double,
      fats: fields[10] as double,
      notes: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MealModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.foodId)
      ..writeByte(3)
      ..write(obj.foodName)
      ..writeByte(4)
      ..write(obj.servings)
      ..writeByte(5)
      ..write(obj.mealType)
      ..writeByte(6)
      ..write(obj.timestamp)
      ..writeByte(7)
      ..write(obj.calories)
      ..writeByte(8)
      ..write(obj.protein)
      ..writeByte(9)
      ..write(obj.carbs)
      ..writeByte(10)
      ..write(obj.fats)
      ..writeByte(11)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

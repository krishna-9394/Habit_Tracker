// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit()
      ..habitName = fields[0] as String
      ..timeSpent = fields[1] as int
      ..goalTime = fields[2] as int
      ..hasStarted = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.habitName)
      ..writeByte(1)
      ..write(obj.timeSpent)
      ..writeByte(2)
      ..write(obj.goalTime)
      ..writeByte(3)
      ..write(obj.hasStarted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

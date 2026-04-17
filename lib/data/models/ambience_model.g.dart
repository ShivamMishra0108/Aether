// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambience_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmbienceAdapter extends TypeAdapter<Ambience> {
  @override
  final int typeId = 0;

  @override
  Ambience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ambience(
      title: fields[0] as String,
      tag: fields[1] as String,
      duration: fields[2] as int,
      audio: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ambience obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.tag)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.audio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmbienceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

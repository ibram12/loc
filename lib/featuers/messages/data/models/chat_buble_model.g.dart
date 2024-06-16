// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_buble_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatBubleModelAdapter extends TypeAdapter<ChatBubleModel> {
  @override
  final int typeId = 1;

  @override
  ChatBubleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatBubleModel(
      id: fields[1] as String,
      massege: fields[0] as String,
      time: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChatBubleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.massege)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatBubleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

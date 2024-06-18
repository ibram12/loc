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
      profileImage: fields[6] as String,
      name: fields[3] as String,
      status: fields[5] as MessageStatus,
      id: fields[1] as String,
      massege: fields[0] as String,
      time: fields[2] as Timestamp,
      docId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatBubleModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.massege)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.docId)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.profileImage);
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

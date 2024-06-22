import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  final int typeId = 2; 

  @override
  Timestamp read(BinaryReader reader) {
    final seconds = reader.readInt();
    final nanoseconds = reader.readInt();
    return Timestamp(seconds, nanoseconds);
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    writer.writeInt(obj.seconds);
    writer.writeInt(obj.nanoseconds);
  }
}

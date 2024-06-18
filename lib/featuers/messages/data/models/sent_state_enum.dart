import 'package:hive/hive.dart';

part 'sent_state_enum.g.dart';

@HiveType(typeId: 3)
enum MessageStatus {
  @HiveField(0)
  sending,
  @HiveField(1)
  sent,
  @HiveField(2)
  error,
}
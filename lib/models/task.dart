import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  bool done;

  @HiveField(3)
  DateTime createdAt;

  Task({
    required this.title,
    this.note,
    this.done = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

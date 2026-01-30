import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String taskTitle;
  @HiveField(1)
  String descraption;
  @HiveField(2)
  String date;
  @HiveField(3)
  String startTime;
  @HiveField(4)
  String endTime;
  @HiveField(5)
  int color;
  TaskModel({
    required this.taskTitle,
    required this.descraption,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
  
}




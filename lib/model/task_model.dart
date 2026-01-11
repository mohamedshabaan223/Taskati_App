
import 'package:flutter/material.dart';

class TaskModel {
  String taskTitle;
  String descraption;
  String date;
  String startTime;
  String endTime;
  Color color;
  TaskModel({required this.taskTitle, required this.descraption , required this.date, required this.startTime, required this.endTime, required this.color});
}
List<TaskModel>tasks =[];
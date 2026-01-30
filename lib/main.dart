import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/task_model.dart';
import 'package:taskati_app/model/user_model.dart';
import 'package:taskati_app/my_app/taskati_app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<UserModel>(ConstStrings.userBox);
  await Hive.openBox<TaskModel>(ConstStrings.tasksBox);
  runApp(const TaskatiApp());
}

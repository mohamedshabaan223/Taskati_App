import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/task_model.dart';
import 'package:taskati_app/ui/add_task_screen.dart';
import 'package:taskati_app/widget/custom_appbar.dart';
import 'package:taskati_app/widget/custom_botton.dart';
import 'package:taskati_app/widget/custom_container_filter.dart';
import 'package:taskati_app/widget/custom_container_task.dart';
import 'package:taskati_app/widget/custom_date_now.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('MMMM d , y');
  List<String> tabs = ['All', 'TODO', 'Complacted'];
  int currentIndex = 0;
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (currentIndex == 0) {
      tasks = Hive.box<TaskModel>(ConstStrings.tasksBox).values.toList();
    } else if (currentIndex == 1) {
      tasks = Hive.box<TaskModel>(ConstStrings.tasksBox).values.toList().where((
        e,
      ) {
        return e.status.toLowerCase() == 'todo';
      }).toList();
    } else {
      tasks = Hive.box<TaskModel>(ConstStrings.tasksBox).values.toList().where((
        e,
      ) {
        return e.status.toLowerCase() == 'complate';
      }).toList();
    }
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  CustomAppbar(),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      CustomDateNow(),
                      Spacer(),
                      CustomBotton(
                        label: 'Add Task',
                        icon: Icons.add,
                        color: Colors.white,
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => AddTaskScreen()),
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      tabs.length,
                      (index) => CustomContainerFilter(
                        isActive: currentIndex == index,
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        label: tabs[index],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Visibility(
                    visible: tasks.isEmpty,
                    replacement: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) => CustomContainerTask(
                        taskModel: tasks[index],
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            deleteTask(index);
                          } else {
                            updateTask(index);
                          }
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: size.height * 0.015),
                      itemCount: tasks.length,
                    ),
                    child: Lottie.asset('assets/images/empty_task.json'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var box = Hive.box<TaskModel>(ConstStrings.tasksBox);
  void deleteTask(int index) {
    box.deleteAt(index);
    setState(() {});
  }

  void updateTask(int index) {
    TaskModel? updateTask = box.getAt(index);
    updateTask?.status = 'Complate';
    updateTask?.save();
    setState(() {});
  }
}

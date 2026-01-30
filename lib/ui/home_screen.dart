import 'dart:io';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/task_model.dart';
import 'package:taskati_app/model/user_model.dart';
import 'package:taskati_app/ui/add_task_screen.dart';
import 'package:taskati_app/ui/auth_screen.dart';
import 'package:taskati_app/widget/custom_container_task.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key ,});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('MMMM d , y');
  UserModel? user = Hive.box<UserModel>(ConstStrings.userBox).getAt(0);
 
  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = Hive.box<TaskModel>(ConstStrings.tasksBox).values.toList();
    return Scaffold(
   body: SafeArea(
     child: ListView(
       children: [
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
         child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Hello,${user?.name ?? ''}' , style: TextStyle(fontSize: 20 , color: Colors.deepPurple, fontWeight: FontWeight.w700), maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Text('Have A Nice Day.' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),)
                ],),
              ),
              CircleAvatar(radius: 30,backgroundImage: Image.file(File(user?.imagePath ?? '')).image),
              IconButton(onPressed: (){
                Hive.box<UserModel>(ConstStrings.userBox).clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>AuthScreen()));
              }, icon: Icon(Icons.logout_outlined , color: Colors.red,)),
            ],
          ),
          SizedBox(height: 15,) ,
          Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateFormat.format(selectedDate) , style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              Text('Today' ,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18), )
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () async{
              await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddTaskScreen()));
            setState(() {
              
            });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18 , vertical: 10),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 18,),
                  SizedBox(width: 3,),
                  Text('Add Task' , style: TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.w700),),
                ],
              )
            ),
          )
          ],),
           SizedBox(height: 15,) ,
          EasyInfiniteDateTimeLine(
            showTimelineHeader: false,
            onDateChange: (date) {
              selectedDate = date;
              setState(() {
                
              });
            },
            firstDate: DateTime(2025),
             focusDate: selectedDate,
             lastDate: DateTime(2027),
             dayProps: EasyDayProps(
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 3.2 , color: Colors.deepPurple)
                )
              ),
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black ,)
                )
              )
             ),
             ),
             SizedBox(height: 15,) ,
             Visibility(
              visible: tasks.isEmpty,
              replacement: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index)=> CustomContainerTask(taskModel: tasks[index],),
                         separatorBuilder: (context, index) => SizedBox(height: 10,),
                         itemCount: tasks.length,),
              child: Lottie.asset('assets/images/empty_task.json'),)
         ],),
       ),
       ], 
     ),
   ),
    );
  }
}

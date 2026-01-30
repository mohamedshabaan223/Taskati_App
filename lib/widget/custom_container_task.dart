import 'package:flutter/material.dart';
import 'package:taskati_app/model/task_model.dart';
import 'package:taskati_app/ui/home_screen.dart';

class CustomContainerTask extends StatelessWidget {
  const CustomContainerTask({super.key , required this.taskModel});
 final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
      color:Color(taskModel.color),
      borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 7,
            children: [
              Text(taskModel.taskTitle , style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700
              ),),
              Row(children: [
                Icon(Icons.alarm , color: Colors.white,), 
                SizedBox(width: 5,),
                Text('${taskModel.startTime}-${taskModel.endTime}' , style: TextStyle(color: Colors.white),)
              ],),
              Text(taskModel.descraption , style: TextStyle(
                fontSize: 16 , 
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),)
          
            ],
          ),
          Spacer(),
          Container(
            width: 3,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text('TODO' , style: TextStyle(color: Colors.white , fontSize: 18, fontWeight: FontWeight.w600),))
        ],
      ),
    );
  }
}
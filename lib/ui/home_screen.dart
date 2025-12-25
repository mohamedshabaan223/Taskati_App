import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/ui/add_task_screen.dart';
import 'package:taskati_app/widget/custom_container_task.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key , required this.name});
  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('MMMM d , y');
  List<Task> tasks=[
    Task(color: Colors.deepPurple , taskName: 'Flutter Task - 1'),
    Task(color: Colors.red , taskName: 'Flutter Task - 2'),
    Task(color: Colors.orange , taskName: 'Flutter Task - 3'),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: SafeArea(
     child: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
       child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Hello,${widget.name}' , style: TextStyle(fontSize: 20 , color: Colors.deepPurple, fontWeight: FontWeight.w700), maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text('Have A Nice Day.' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),)
              ],),
            ),
            CircleAvatar(radius: 30, backgroundColor: Colors.black,child: Icon(Icons.person, size: 30, color: Colors.deepPurple,),)
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
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddTaskScreen())),
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
           lastDate: DateTime(2027)),
           SizedBox(height: 15,) ,
           Expanded(child: ListView.separated(itemBuilder: (_, index)=> CustomContainerTask(task: tasks[index]),
           separatorBuilder: (context, index) => SizedBox(height: 10,),
           itemCount: tasks.length,)
           )
       ],),
     ),
   ),
    );
  }
}
class Task{
  String taskName;
  String? selectedDate;
  Color color;
  Task({ required this.taskName , this.selectedDate ,required this.color });
}
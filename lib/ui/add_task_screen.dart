import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/task_model.dart';
import 'package:taskati_app/widget/custom_eleveted_button.dart';
import 'package:taskati_app/widget/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descraptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TimeOfDay startTimeOfDay =  TimeOfDay.now();
  TimeOfDay endTimeOfDay = TimeOfDay.now();
  int activeIndex= -1;
  List<MaterialColor> taskColor = [
    Colors.deepPurple,
    Colors.orange,
    Colors.red,
    Colors.cyan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        title: Text(
          'Add Task',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: titleController,
                hintlabel: 'Enter Title',
                colorHintText: Colors.black,
              ),
              SizedBox(height: 10),
              Text(
                'Descraption',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: descraptionController,
                maxLines: 3,
                hintlabel: 'Enter Descraption',
                colorHintText: Colors.black,
              ),
              SizedBox(height: 10),
              Text(
                'Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: dateController,
                readOnly: true,
                suffixIcon: Icon(Icons.date_range),
                hintlabel: dateFormat.format(selectedDate),
                colorHintText: Colors.black,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2040),
                    initialDate: selectedDate,
                  );
                  dateController.text = DateFormat(
                    'yyyy-MM-dd',
                  ).format(date ?? DateTime.now());
                  if (date != null) {
                    selectedDate = date;
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: startTimeController,
                          suffixIcon: Icon(Icons.alarm),
                          readOnly: true,
                          hintlabel: '00:00',
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              startTimeController.text =
                                  value?.format(context) ??
                                  TimeOfDay.now().format(context);
                              startTimeOfDay = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: endTimeController,
                          suffixIcon: Icon(Icons.alarm),
                          readOnly: true,
                          hintlabel: '00:00 ',
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              endTimeController.text =
                                  value?.format(context) ??
                                  TimeOfDay.now().format(context);
                              endTimeOfDay = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Color',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Row(
                children: List.generate(
                  taskColor.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: InkWell(
                      onTap: () {
                        activeIndex = index;
                        setState(() {
                          
                        });
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: taskColor[index],
                        
                          child: activeIndex == index ? Icon(Icons.done_all_rounded , color: Colors.white,):null),
                      ),
                    ),
                  ),
                ),
              

              SizedBox(height: 100),
              CustomElevetedButton(
                label: 'Create Task',
                onPressed: () {
                 if ( formKey.currentState?.validate()??false) {
                  if (activeIndex == -1) {
                    showDialog(context: context, builder: (context)=>
                    AlertDialog(
                      title: Text('Error!'),
                      content: Text('Please Choose Task Color'),
                      actions: [
                        CustomElevetedButton(label: 'ok', onPressed: () {
                          Navigator.pop(context);
                        },)
                      ],
                    ));

                  }
                  Hive.box<TaskModel>(ConstStrings.tasksBox).add(TaskModel(
                    taskTitle: titleController.text,
                     descraption: descraptionController.text, 
                     date: dateController.text,
                      startTime: startTimeController.text,
                       endTime: endTimeController.text,
                        color: taskColor[activeIndex].toARGB32())).then((value){
                          Navigator.pop(context);
                        });
                 }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

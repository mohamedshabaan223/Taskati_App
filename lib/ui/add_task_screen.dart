import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  TimeOfDay startTimeOfDay = TimeOfDay.now();
  TimeOfDay endTimeOfDay = TimeOfDay.now();
  bool isSelected = false;

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
                  var date = await showDatePicker(
                    
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2040),
                    initialDate: selectedDate,
                  );
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
                          hintlabel: '09:08 PM',
                          onTap: () async {
                            var time = await showTimePicker(
                              context: context,
                              initialTime: startTimeOfDay,
                            );
                            if (time != null) {
                              startTimeOfDay = time;
                              setState(() {});
                            }
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
                          hintlabel: '09:08 PM',
                          onTap: () async {
                            var time = await showTimePicker(
                              context: context,
                              initialTime: endTimeOfDay,
                            );
                            if (time != null) {
                              endTimeOfDay = time;
                              setState(() {});
                            }
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
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                         CircleAvatar(
                                                 radius: 25,
                                                 backgroundColor: index == 0
                            ?  Colors.deepPurple
                            : index == 1
                            ? Colors.orange
                            : Colors.red,
                                               ),
                         
                    Icon(Icons.done, color: index == 0 ?Colors.white : Colors.transparent , size: 30,)
                      ],
                    )
                  ),
                ),
              ),

              SizedBox(height: 100),
              CustomElevetedButton(
                label: 'Create Task',
                onPressed: () {
                  formKey.currentState?.validate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

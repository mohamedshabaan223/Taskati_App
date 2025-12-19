import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/ui/home_screen.dart';
import 'package:taskati_app/widget/custom_eleveted_button.dart';
import 'package:taskati_app/widget/custom_text_form_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
   XFile? photo;
  void pickCamera() async{
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      
    });
  }
   void pickGallery() async{
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key:formKey ,
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: photo == null,
                    replacement: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black,
                      backgroundImage: Image.file(File(photo?.path ?? '')).image,
                    ),
                    child:  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person_2, size: 100, color: Colors.deepPurple),
                  ),),
                 
                  SizedBox(height: 30),
                  CustomElevetedButton(
                    label: 'Uploading from camera',
                    onPressed: () {
                      pickCamera();
                    },
                  ),
                  SizedBox(height: 15),
                  CustomElevetedButton(
                    label: 'Uploading from gallery',
                    onPressed: () {
                      pickGallery();
                    },
                  ),
                  SizedBox(height: 40,),
                  CustomTextFormField(
                    controller: nameController , 
                    hintlabel: 'Enter your name',
                     labelText: 'Name',
                     validator: (value) {
                       if (value == null || value.trim().isEmpty) {
                         return 'Please Enter your name';
                       }else if( value.length < 3){
                           return 'the length of name at least 3';
                       }
                       else  {
                        return null;
                       }
                     },),
                     SizedBox(height: 20,),
                     CustomElevetedButton(label: 'login' , onPressed: () {
                    if(formKey.currentState!.validate()){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomeScreen(name: nameController.text,),),);
                    }
                    
                     },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
}

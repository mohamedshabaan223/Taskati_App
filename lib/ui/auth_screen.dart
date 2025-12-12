import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/widget/custom_eleveted_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
           
            SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
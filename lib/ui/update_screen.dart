import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive;
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/user_model.dart';
import 'package:taskati_app/ui/home_screen.dart';
import 'package:taskati_app/widget/custom_eleveted_button.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  UserModel? user = Hive.box<UserModel>(ConstStrings.userBox).getAt(0);
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  void pickCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void pickGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  TextEditingController nameController = TextEditingController();
  String name = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Update Task',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: Image.file(
                    File(user?.imagePath ?? ''),
                  ).image,
                ),
                Positioned(
                  left: 150,
                  top: 160,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomElevetedButton(
                                label: 'Uploading from camera',
                                onPressed: () {
                                   updatePhoto();
                                  pickCamera();
                                 Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: height * 0.02),
                              CustomElevetedButton(
                                label: 'Uploading from gallery',
                                onPressed: () {
                                  pickGallery();
                                  updatePhoto();
                                   Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.deepPurple,
                      ),
                      child: Icon(Icons.photo, color: Colors.white, size: 25),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: height * 0.06,
              thickness: 2,
              color: Colors.deepPurple,
              endIndent: width * 0.07,
              indent: width * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user?.name ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,

                      builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: user?.name,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomElevetedButton(
                              label: 'Save',
                              onPressed: () {
                                updateName();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.deepPurple,
                    ),
                    child: Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  var box = Hive.box<UserModel>(ConstStrings.userBox);
  void updateName() {
    UserModel? user = box.getAt(0);
    user?.name = name;
    user?.save();
    setState(() {});
  }

  void updatePhoto() {
    UserModel? user = box.getAt(0);
    user?.imagePath = photo?.path ?? '';
user?.save();
   setState(() {
     
   });
    }
  }


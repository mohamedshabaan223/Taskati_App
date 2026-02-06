import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/user_model.dart';
import 'package:taskati_app/ui/auth_screen.dart';
import 'package:taskati_app/ui/update_screen.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({super.key});

  UserModel? user = Hive.box<UserModel>(ConstStrings.userBox).getAt(0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,${user?.name ?? ''}',
                
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Have A Nice Day.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
            radius: 30,
            backgroundImage: Image.file(File(user?.imagePath ?? '')).image,
          ),
          Positioned

          (
            
            left: 35,
            top: 37,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateScreen()));
              },
              child: Container(
                padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.deepPurple,
              
              ),
              child: Icon(Icons.edit, color: Colors.white, size: 20,),
                        ),
            ))
          ],
        ),
        IconButton(
          onPressed: () {
            Hive.box<UserModel>(ConstStrings.userBox).clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AuthScreen()),
            );
          },
          icon: Icon(Icons.logout_outlined, color: Colors.red),
        ),
      ],
    );
  }
}

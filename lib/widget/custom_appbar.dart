import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati_app/common/const_strings.dart';
import 'package:taskati_app/model/user_model.dart';
import 'package:taskati_app/ui/auth_screen.dart';

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
        CircleAvatar(
          radius: 30,
          backgroundImage: Image.file(File(user?.imagePath ?? '')).image,
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

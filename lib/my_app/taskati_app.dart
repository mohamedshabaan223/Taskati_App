import 'package:flutter/material.dart';
import 'package:taskati_app/ui/splash_screen.dart';

class TaskatiApp extends StatelessWidget {
  const TaskatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/quiz_screen.dart';          

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legyen On Is Milliomos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuScreen()
    );
  }
}
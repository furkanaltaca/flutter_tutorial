import 'package:flutter/material.dart';
import 'package:flutter_tutorial/screens/studentList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: Colors.white),
      home: StudentList()
    );
  }
}

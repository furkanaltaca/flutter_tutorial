import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/Student.dart';

void main() => runApp(MyApp());

String appBarText = "Öğrenci Takip Sistemi";
final myAppBackgroundColor = Colors.blue;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: myAppBackgroundColor),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  List<Student> studentList = [
    Student.withId(911, "Furkan", "Altaca", 80),
    Student.withId(911, "Kasım", "Şahin", 85),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(appBarText)), body: buildBody());
  }

  Widget buildBody() {
    return Center(
      child: Text(
        "My First Flutter App",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

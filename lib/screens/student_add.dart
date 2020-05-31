import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/Student.dart';

class StudentAdd extends StatefulWidget {
  final List<Student> students;

  StudentAdd(this.students);

  @override
  State<StatefulWidget> createState() {
    return StudentAddState();
  }
}

class StudentAddState extends State<StudentAdd> {
  var formKey = GlobalKey<FormState>();
  var student = Student("", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Öğrenci")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      initialValue: "ad",
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Furkan"),
      onSaved: (String value) {
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: "soyad",
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Altaca"),
      onSaved: (String value) {
        student.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: "67",
      decoration: InputDecoration(labelText: "Aldığı Not", hintText: "65"),
      onSaved: (String value) {
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        child: Text(
          "Kaydet",
          style: TextStyle(color: Colors.black),
        ),
        color: Colors.yellow,
        onPressed: () {
          formKey.currentState.save();
          widget.students.add(student);
          Navigator.pop(context);
        },
      ),
    );
  }
}

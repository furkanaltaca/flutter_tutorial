import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/Student.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;
  Student student;
  bool isUpdateMode = false;

  StudentAdd(this.students);
  StudentAdd.forUpdate(this.students, this.student) {
    isUpdateMode = true;
  }

  @override
  State<StatefulWidget> createState() {
    return StudentAddState();
  }
}

class StudentAddState extends State<StudentAdd> {
  var formKey = GlobalKey<FormState>();
  var newStudent = Student("", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isUpdateMode ? "Güncelle" : "Yeni Öğrenci")),
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
      initialValue: widget.isUpdateMode ? widget.student.firstName : "",
      decoration: InputDecoration(
        labelText: "Öğrenci Adı",
      ),
      onSaved: (String value) {
        newStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: widget.isUpdateMode ? widget.student.lastName : "",
      decoration: InputDecoration(labelText: "Öğrenci Soyadı"),
      onSaved: (String value) {
        newStudent.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: widget.isUpdateMode ? widget.student.grade.toString() : "",
      decoration: InputDecoration(labelText: "Aldığı Not"),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        newStudent.grade = int.parse(value);
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
          if (widget.isUpdateMode) {
            formKey.currentState.save();
            newStudent.id = widget.student.id;
            var updatedStudent = widget.students
                .where((element) => element.id == newStudent.id)
                .first;
            updatedStudent.firstName = newStudent.firstName;
            updatedStudent.lastName= newStudent.lastName;
            updatedStudent.grade = newStudent.grade;
            Navigator.pop<Student>(context, updatedStudent);
          } else {
            formKey.currentState.save();
            widget.students.add(newStudent);
            Navigator.pop<Student>(context, newStudent);
          }
        },
      ),
    );
  }
}

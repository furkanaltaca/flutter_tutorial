import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tutorial/models/Student.dart';

class StudentSave extends StatefulWidget {
  List<Student> students;
  Student student;
  bool isUpdateMode = false;

  StudentSave(this.students);
  StudentSave.forUpdate(this.students, this.student) {
    isUpdateMode = true;
  }

  @override
  State<StatefulWidget> createState() {
    return StudentSaveState();
  }
}

class StudentSaveState extends State<StudentSave> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  var newStudent = Student.withId(null, "", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(widget.isUpdateMode ? "Güncelle" : "Yeni Öğrenci")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Öğrencinin adını giriniz.';
        }
        return null;
      },
      decoration: InputDecoration(labelText: "Öğrencinin Adı"),
      onSaved: (String value) {
        newStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: widget.isUpdateMode ? widget.student.lastName : "",
      validator: (value) {
        if (value.isEmpty) {
          return 'Öğrencinin soyadını giriniz.';
        }
        return null;
      },
      decoration: InputDecoration(labelText: "Öğrencinin Soyadı"),
      onSaved: (String value) {
        newStudent.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: widget.isUpdateMode ? widget.student.grade.toString() : "",
      validator: (value) {
        if (value.isEmpty)
          return 'Öğrencinin aldığı notu giriniz.';
        else {
          int val = int.parse(value);
          if ((val < 0 || val > 100)) 
            return "Not 0-100 aralığında olmalıdır.";
        }
        return null;
      },
      decoration: InputDecoration(labelText: "Aldığı Not"),
      keyboardType: TextInputType.number,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
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
          if (!_formKey.currentState.validate()) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Girdiğiniz bilgileri kontrol ediniz."),
            ));
          } else {
            _formKey.currentState.save();
            if (widget.isUpdateMode) {
              newStudent.id = widget.student.id;
              var updatedStudent = widget.students
                  .where((element) => element.id == newStudent.id)
                  .first;
              updatedStudent.firstName = newStudent.firstName;
              updatedStudent.lastName = newStudent.lastName;
              updatedStudent.grade = newStudent.grade;
              Navigator.pop<Student>(context, updatedStudent);
            } else {
              widget.students.add(newStudent);
              Navigator.pop<Student>(context, newStudent);
            }
          }
        },
      ),
    );
  }
}

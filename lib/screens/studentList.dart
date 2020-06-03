import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/Student.dart';
import 'package:flutter_tutorial/screens/studentSave.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Student> studentList = [
    Student.withId(911, "Furkan", "Altaca", 100),
    Student.withId(123, "Mehmet Hazar", "Ertürk", 49),
    Student.withId(456, "Mehmet", "Aksu", 39),
    Student.withId(345, "Kasım", "Şahin", 50)
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void setState(fn) {
    super.setState(() {
      fn();
      // getStudentList(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Öğrenciler"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Yeni öğrenci ekle",
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentSave(studentList)))
                  .then((value) {
                setState(() {});
                var student = value as Student;
                buildSnackBar(
                    "${student.firstName.toString()} ${student.lastName.toString()} eklendi.");
              });
            },
          )
        ],
      ),
      body: Container(margin: EdgeInsets.only(top: 10), child: buildBody()),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, int i) {
                final student = studentList[i];
                return Dismissible(
                  key: Key(student.firstName),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    var deletedStudent;
                    setState(() {
                      deletedStudent = studentList.removeAt(i);
                    });
                    buildSnackBar(
                        "${student.firstName} ${student.lastName} silindi.",
                        isUndoButton: true,
                        item: deletedStudent,
                        index: i);
                  },
                  background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete)),
                  child: ListTile(
                    title: Text("${student.firstName} ${student.lastName}"),
                    subtitle: Text(
                        "Sınav Notu: ${student.grade.toString()}\n[${student.getStatus}]"),
                    leading: CircleAvatar(child: Icon(Icons.person_outline)),
                    trailing: buildStatusIcon(student.grade),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentSave.forUpdate(
                                  studentList, studentList[i]))).then((value) {
                        setState(() {});
                        var student = value as Student;
                        buildSnackBar(
                            "${student.firstName.toString()} ${student.lastName.toString()} güncellendi.");
                      });
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade > 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }

  buildSnackBar(String text,
      {bool isUndoButton = false, Object item, int index}) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(text),
        action: isUndoButton
            ? SnackBarAction(
                onPressed: () {
                  setState(() {
                    studentList.insert(index, item);
                  });
                },
                textColor: Colors.blue,
                label: "Geri Al",
              )
            : null));
  }
}

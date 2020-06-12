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

  var _scaffoldKey = GlobalKey<ScaffoldState>();

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
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(child: Text("Drawer Header"),),
      //       ListTile(title: Text("Tile 1"),onTap: (){
      //         Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentSave(studentList)));
      //       },),
      //       ListTile(title: Text("Tile 1"),),
      //       ListTile(title: Text("Tile 1"),),
      //       ListTile(title: Text("Tile 1"),),
      //       ListTile(title: Text("Tile 1"),),
      //     ],
      //   ),
      // ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Öğrenciler"),
      ),
      body: Container(child: buildBody()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
      ),
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
                  background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete_outline,color: Colors.white,)),
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
      return Icon(Icons.check_circle_outline);
    } else if (grade > 40) {
      return Icon(Icons.adjust);
    } else {
      return Icon(Icons.remove_circle_outline);
    }
  }

  buildSnackBar(String text,
      {bool isUndoButton = false, Object item, int index}) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
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

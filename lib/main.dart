import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/Student.dart';
import 'package:flutter_tutorial/screens/student_add.dart';

void main() => runApp(MyApp());

final myAppBackgroundColor = Colors.blue;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: myAppBackgroundColor),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> studentList = [
    Student.withId(911, "Furkan", "Altaca", 100),
    Student.withId(123, "Mehmet Hazar", "Ertürk", 49),
    Student.withId(456, "Mehmet", "Aksu", 39),
    Student.withId(345, "Kasım", "Şahin", 50)
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                          builder: (context) => StudentAdd(studentList)))
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
                    setState(() {
                      studentList.removeAt(i);
                    });
                    buildSnackBar(
                        "${student.firstName} ${student.lastName} silindi.");
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
                              builder: (context) => StudentAdd.forUpdate(
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

  buildSnackBar(String text) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }
}

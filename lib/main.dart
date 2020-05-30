import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/Student.dart';

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
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> studentList = [
    Student.withId(911, "Furkan", "Altaca", 100),
    Student.withId(911, "Mehmet Hazar", "Ertürk", 49),
    Student.withId(911, "Mehmet", "Aksu", 39),
    Student.withId(911, "Kasım", "Şahin", 50),
  ];

  Student selectedStudent = Student.withId(0, "Hiç Kimse", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Öğrenci Takip Sistemi")),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(
                      studentList[i].firstName + " " + studentList[i].lastName),
                  subtitle: Text(
                      "Sınavdan aldığı not: ${studentList[i].grade.toString()} [${studentList[i].getStatus}]"),
                  leading: CircleAvatar(child: Icon(Icons.person_outline)),
                  trailing: buildStatusIcon(studentList[i].grade),
                  onTap: () {
                    setState(() {
                      selectedStudent=studentList[i];
                    });
                  },
                  onLongPress: () {
                    print("Uzun basıldı");
                  },
                );
              }),
        ),
        Text("Seçili öğe ${selectedStudent.firstName}")
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
}

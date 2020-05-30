class Student {
  int id;
  String firtName;
  String lastName;
  int grade;
  String status;

  Student(String firstName, String lastName, int grade) {
    this.firtName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  Student.withId(int id,String firstName, String lastName, int grade) {
    this.id=id;
    this.firtName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
}

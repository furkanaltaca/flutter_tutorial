class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  String status;

  Student(String firstName, String lastName, int grade) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  Student.withId(int id, String firstName, String lastName, int grade) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }

  String get getStatus {
    if (this.grade >= 50) {
      this.status = "Geçti";
    } else if (this.grade > 40) {
      this.status = "Bütünlemeye kaldı";
    } else {
      this.status = "Kaldı";
    }
    return this.status;
  }
}

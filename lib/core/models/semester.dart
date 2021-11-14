import 'course.dart';

class Semester {
  List<Course> courses = [];

  int get courseUnits => courses
      .map((course) => course.courseUnit)
      .toList()
      .fold(0, (previousValue, element) => previousValue + element);
  int get gradePoints => courses
      .map((course) => course.gradePoint)
      .toList()
      .fold(0, (previousValue, element) => previousValue + element);

  double get SGPA => gradePoints / courseUnits;
}

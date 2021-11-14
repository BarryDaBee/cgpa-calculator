import 'package:cgpa_calculator_1/core/models/course.dart';
import 'package:cgpa_calculator_1/core/models/semester.dart';
import 'package:stacked/stacked.dart';

class SGPAViewModel extends BaseViewModel {
  final List<Semester> semesters = [];
  int get totalCourseUnits {
    int total = 0;
    for (var element in semesters) {
      total += element.courseUnits;
    }
    return total;
  }

  double get cgpa {
    int gradePoint = 0;
    for (var element in semesters) {
      gradePoint += element.gradePoints;
    }
    return gradePoint / totalCourseUnits;
  }

  addCourse(int semesterIndex) {
    semesters[semesterIndex].courses.add(Course());
    notifyListeners();
  }

  addSemester() {
    semesters.add(Semester());
    notifyListeners();
  }

  updateGrade(int grade, int semesterIndex, int courseIndex) {
    semesters[semesterIndex].courses[courseIndex].grade = grade;
    notifyListeners();
  }

  updateCourseUnit(int courseUnit, int semesterIndex, int courseIndex) {
    semesters[semesterIndex].courses[courseIndex].courseUnit = courseUnit;
    notifyListeners();
  }

  updateCourseCode(String courseCode, int semesterIndex, int courseIndex) {
    semesters[semesterIndex].courses[courseIndex].courseCode = courseCode;

    //notifyListeners();
  }

  calculateGPA() {
    notifyListeners();
  }

  removeCourse(int semesterIndex, int courseIndex) {
    semesters[semesterIndex].courses.removeAt(courseIndex);
    notifyListeners();
  }
}

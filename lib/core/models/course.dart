class Course {
  String courseTitle = "Tap to edit course title";
  String courseCode = "Tap to edit course code";
  int courseUnit = 0;
  int grade = 5;
  double score = 0;

  int get gradePoint => courseUnit * grade;
}

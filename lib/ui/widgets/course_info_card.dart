import 'package:cgpa_calculator_1/core/models/course.dart';
import 'package:cgpa_calculator_1/ui/shared/colors.dart';
import 'package:cgpa_calculator_1/ui/views/sgpa_view/sgpa_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseInfoCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;
  final int courseIndex;
  final int semesterIndex;
  final SGPAViewModel model;

  CourseInfoCard({
    Key? key,
    required this.course,
    this.onTap,
    required this.model,
    required this.courseIndex,
    required this.semesterIndex,
  }) : super(key: key);

  final List<String> gradeRange = [
    ">= 70",
    "60-69",
    "50-59",
    "45-49",
    "40-44",
    "< 40"
  ];

  double score = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.cream,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.h,
                width: 250.w,
                child: TextFormField(
                  initialValue: course.courseCode,
                  style: GoogleFonts.karla(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Edit course code',
                    hintStyle: GoogleFonts.karla(
                      color: Colors.grey[600],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (courseCode) {
                    model.updateCourseCode(
                        courseCode, semesterIndex, courseIndex);
                  },
                ),
              ),
              // CustomText(
              //   course.courseTitle,
              //   color: Colors.black,
              //   fontSize: 16,
              //   fontWeight: FontWeight.w700,
              // ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Course Units',
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 50.w,
                        height: 23.h,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            onChanged: (courseUnit) {
                              model.updateCourseUnit(
                                  courseUnit!, semesterIndex, courseIndex);
                              //print(course.gradePoint);
                            },
                            value: course.courseUnit,
                            items: List.generate(
                              7,
                              (index) => DropdownMenuItem(
                                child: CustomText((index).toString()),
                                value: index,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Grade (%)',
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 80.w,
                        height: 23.h,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            onChanged: (grade) {
                              model.updateGrade(
                                  grade!, semesterIndex, courseIndex);
                            },
                            value: course.grade,
                            items: List.generate(
                              gradeRange.length,
                              (index) => DropdownMenuItem(
                                child: CustomText(gradeRange[index]),
                                value: (index + 1 - gradeRange.length).abs(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Grade (Letter)',
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        getGradeLetter(course.grade)!,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 10.h),
          const Icon(
            Icons.chevron_right,
            color: AppColors.brown,
          ),
        ],
      ),
    );
  }

  String? getGradeLetter(int grade) {
    switch (grade) {
      case 5:
        return 'A';
      case 4:
        return 'B';
      case 3:
        return 'C';
      case 2:
        return 'D';
      case 1:
        return 'E';
      case 0:
        return 'F';
    }
  }
}

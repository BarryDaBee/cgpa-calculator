import 'package:cgpa_calculator_1/core/locator.dart';
import 'package:cgpa_calculator_1/core/models/semester.dart';
import 'package:cgpa_calculator_1/ui/shared/colors.dart';
import 'package:cgpa_calculator_1/ui/widgets/course_info_card.dart';
import 'package:cgpa_calculator_1/ui/widgets/custom_text.dart';
import 'package:cgpa_calculator_1/core/exports.dart';
import 'package:cgpa_calculator_1/ui/views/sgpa_view/sgpa_view_model.dart';

class SGPAView extends StatelessWidget {
  final int semesterIndex;
  const SGPAView({Key? key, required this.semesterIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SGPAViewModel>.reactive(
      viewModelBuilder: () {
        return locator.get<SGPAViewModel>();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        Semester semester = model.semesters[semesterIndex];
        return Scaffold(
          body: Column(
            children: [
              Container(
                color: AppColors.red,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 24.w,
                  right: 24.w,
                  bottom: 5.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomText(
                      'GPA Calculator',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Semester ${semesterIndex + 1}',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              'Your GPA',
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              semester.SGPA.toStringAsPrecision(3),
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppColors.lemon,
                            ),
                          ],
                        ),
                        SizedBox(width: 50.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              'Total Units',
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              semester.courseUnits.toString(),
                              fontWeight: FontWeight.w400,
                              color: Colors.black26,
                              fontSize: 28,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        model.addCourse(semesterIndex);
                      },
                      child: buildAddCourse(),
                    ),
                    SizedBox(height: 20.h),
                    ListView.separated(
                      reverse: true,
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, courseIndex) {
                        var courses = semester.courses;
                        return Dismissible(
                          onDismissed: (_) {
                            model.removeCourse(semesterIndex, courseIndex);
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 30.r,
                                  color: Colors.white,
                                ),
                                const CustomText(
                                  'Delete',
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                          key: UniqueKey(),
                          child: CourseInfoCard(
                            courseIndex: courseIndex,
                            course: courses[courseIndex],
                            semesterIndex: semesterIndex,
                            model: model,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: semester.courses.length,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddCourse() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade600, width: 1),
        color: AppColors.lightGrey,
      ),
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: 15,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 2),
          CustomText(
            'New Course',
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

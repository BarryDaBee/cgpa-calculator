import 'package:cgpa_calculator_1/core/exports.dart';
import 'package:cgpa_calculator_1/ui/views/sgpa_view/sgpa_view.dart';
import 'package:cgpa_calculator_1/ui/views/sgpa_view/sgpa_view_model.dart';
import 'package:cgpa_calculator_1/ui/widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SGPAViewModel>.reactive(
        viewModelBuilder: () => locator<SGPAViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          'Your CGPA',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          model.cgpa.toStringAsPrecision(3),
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
                          fontSize: 12,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          model.totalCourseUnits.toString(),
                          fontWeight: FontWeight.w400,
                          color: Colors.black26,
                          fontSize: 28,
                        ),
                      ],
                    ),
                  ],
                ),

                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.w, horizontal: 20.w),
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SGPAView(
                                semesterIndex: index,
                              ),
                            ),
                          );
                        },
                        child: SemesterCard(semesterIndex: index, model: model),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 20.h),
                      itemCount: model.semesters.length,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: InkWell(
                    onTap: () {
                      model.addSemester();
                    },
                    child: buildAddSemester(),
                  ),
                ),
                //SizedBox(height: 20.h),
              ],
            ),
          );
        });
  }

  Widget buildAddSemester() {
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
            'New Semester',
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

class SemesterCard extends StatelessWidget {
  final SGPAViewModel model;
  final int semesterIndex;
  const SemesterCard({
    Key? key,
    required this.model,
    required this.semesterIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          CustomText(
            "Semester ${semesterIndex + 1}",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    'Course Units',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    model.semesters[semesterIndex].courseUnits.toString(),
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                    fontSize: 18,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    'Grade Point Average',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    model.semesters[semesterIndex].SGPA.toStringAsPrecision(3),
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
    );
  }
}

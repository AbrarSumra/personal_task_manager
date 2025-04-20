import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_task_manager/app/app_theme/app_theme.dart';
import 'package:personal_task_manager/app/custom_widget/button_l.dart';
import 'package:personal_task_manager/app/custom_widget/navigation_class.dart';
import 'package:personal_task_manager/app/custom_widget/text_constant.dart';
import 'package:personal_task_manager/app/custom_widget/widgets.dart';
import 'package:personal_task_manager/auth/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 26.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox(23),
              SvgPicture.asset('assets/icons/Group 5.svg'),
              heightBox(20),
              Container(
                width: 369.w,
                height: 330.h,
                color: Colors.white,
                child: SvgPicture.asset(
                  'assets/icons/pana.svg',
                  width: 321.w,
                  height: 320.h,
                ),
              ),
              heightBox(20),
              NormalText(
                title: 'Manage \nyour \nTask with',
                color: Colors.white,
                fontSize: 45,
                height: 0,
              ),
              NormalText(
                title: 'DayTask',
                color: AppColor.kAppYellowColor,
                fontSize: 45,
                height: 0,
              ),
              heightBox(20),
              ButtonL(
                title: 'Let\'s Start',
                onTap: () {
                  NavigationClass.pushWithSlideTransition(
                      context: context, page: LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

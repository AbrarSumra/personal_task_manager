import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_task_manager/app/custom_widget/text_constant.dart';

import '../app_theme/app_theme.dart';

class ButtonL extends StatelessWidget {
  const ButtonL({
    super.key,
    required this.title,
    this.titleColor = AppColor.kBlackColor,
    required this.onTap,
    this.btnColor = AppColor.kAppYellowColor,
    this.isLoading = false,
    this.height = 50,
    this.width = double.infinity,
  });

  final String title;
  final Color titleColor;
  final Function()? onTap;
  final Color btnColor;
  final bool isLoading;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? Colors.grey : btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? SizedBox(
                height: height.h / 2,
                width: height.h / 2,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : FittedBox(
                child: NormalText(
                  title: title,
                  fontSize: 14,
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

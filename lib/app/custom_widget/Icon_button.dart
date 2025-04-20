import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_task_manager/app/custom_widget/text_constant.dart';
import 'package:personal_task_manager/app/custom_widget/widgets.dart';

import '../app_theme/app_theme.dart';

class IconButtonL extends StatelessWidget {
  const IconButtonL({
    super.key,
    required this.title,
    this.titleColor = AppColor.kWhiteColor,
    required this.onTap,
    this.btnColor = AppColor.kAppMainColor,
    this.isLoading = false,
    this.height = 50,
    this.width = double.infinity,
    this.imgPath,
  });

  final String title;
  final Color titleColor;
  final Function()? onTap;
  final Color btnColor;
  final bool isLoading;
  final double height;
  final double width;
  final String? imgPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : FittedBox(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      imgPath ?? 'assets/icons/google.svg',
                      height: 24.h,
                      width: 24.h,
                    ),
                    widthBox(10),
                    NormalText(
                      title: title,
                      fontSize: 14,
                      color: titleColor,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

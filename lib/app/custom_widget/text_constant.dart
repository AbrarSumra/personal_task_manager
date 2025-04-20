import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_theme/app_theme.dart';

class NormalText extends StatelessWidget {
  const NormalText({
    required this.title,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
    this.color = AppColor.kWhiteColor,
    this.textOverflow,
    super.key,
    this.textAlign,
    this.maxLines,
    this.height,
    this.textDecoration,
    this.fontStyle = FontStyle.normal,
    this.decorationColor,
    this.softWrap = false,
  });

  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final String title;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final Color? decorationColor;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: textStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        textDecoration: textDecoration,
        fontStyle: fontStyle,
        decorationColor: decorationColor,
      ),
    );
  }
}

TextStyle textStyle({
  FontWeight? fontWeight,
  Color? color,
  double? fontSize,
  double? height,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  Color? decorationColor,
}) {
  return GoogleFonts.inter(
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color,
    fontSize: kIsWeb
        ? (fontSize ?? 16) * 1.1
        : (fontSize != null ? fontSize.sp : 16.sp),
    height: height,
    decoration: textDecoration,
    decorationColor: decorationColor,
    fontStyle: fontStyle,
  );
}

TextStyle textStyle2({
  FontWeight? fontWeight,
  Color? color,
  double? fontSize,
  double? height,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  Color? decorationColor,
}) {
  return GoogleFonts.inter(
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color,
    fontSize: kIsWeb
        ? (fontSize ?? 16) * 1.1
        : (fontSize != null ? fontSize.sp : 16.sp),
    height: height,
    decoration: textDecoration,
    decorationColor: decorationColor,
    fontStyle: fontStyle,
  );
}

class NormalText2 extends StatelessWidget {
  const NormalText2({
    required this.title,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
    this.color = AppColor.kDarkGreyColor,
    this.textOverflow,
    super.key,
    this.textAlign,
    this.maxLines,
    this.height,
    this.textDecoration,
    this.fontStyle = FontStyle.normal,
    this.decorationColor,
    this.softWrap = false,
  });

  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final String title;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final Color? decorationColor;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: textStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        textDecoration: textDecoration,
        fontStyle: fontStyle,
        decorationColor: decorationColor,
      ),
    );
  }
}

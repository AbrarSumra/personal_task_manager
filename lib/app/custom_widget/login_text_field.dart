import 'package:flutter/material.dart';

import '../app_theme/app_theme.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    super.key,
    this.hintText,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.hintTextColor = Colors.white,
    this.iconColor = Colors.black,
    this.keyboardType = TextInputType.text,
    this.fontColor = AppColor.kWhiteColor,
    this.validator,
    this.obscureText = false,
  });

  final String? hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final Color hintTextColor;
  final Color fontColor;
  final Color iconColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: fontColor),
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColor.kAppLightBlueColor,
        counterText: '',
        hintStyle: TextStyle(color: hintTextColor),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: Colors.white,
          ),
          onPressed: onSuffixTap,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kAppLightBlueColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kAppLightBlueColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kAppLightBlueColor),
        ),
      ),
      validator: validator,
    );
  }
}

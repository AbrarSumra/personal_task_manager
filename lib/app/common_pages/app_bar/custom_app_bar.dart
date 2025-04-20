import 'package:flutter/material.dart';

import '../../app_theme/app_theme.dart';
import '../../custom_widget/text_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final double elevation;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.backgroundColor = AppColor.kAppMainColor,
    this.foregroundColor = AppColor.kWhiteColor,
    this.actions,
    this.leading,
    this.elevation = 0.0,
    this.centerTitle = false,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      bottom: bottom,
      title: Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (subtitle != null)
            NormalText(
              title: subtitle!,
              fontSize: 10,
              color: AppColor.kAppYellowColor,
            ),
          NormalText(title: title),
        ],
      ),
    );
  }
}

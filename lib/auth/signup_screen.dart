import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_task_manager/app/custom_widget/navigation_class.dart';
import 'package:provider/provider.dart';
import '../app/app_theme/app_theme.dart';
import '../app/custom_widget/Icon_button.dart';
import '../app/custom_widget/button_l.dart';
import '../app/custom_widget/login_text_field.dart';
import '../app/custom_widget/text_constant.dart';
import '../app/custom_widget/widgets.dart';
import '../provider/auth_service_provider.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      auth.registerEmailController.clear();
      auth.registerPasswordController.clear();
      auth.agreeCheckBox = false;
    });

    return Scaffold(
      backgroundColor: AppColor.kAppBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 26.h),
        child: Consumer<AuthServiceProvider>(
          builder: (_, provider, child) {
            return Column(
              children: [
                heightBox(23),
                SvgPicture.asset('assets/icons/Group 5.svg'),
                heightBox(23),
                Row(
                  children: [
                    NormalText(
                      title: 'Create your account',
                      fontSize: 26,
                    ),
                  ],
                ),
                heightBox(16),
                Row(
                  children: [
                    NormalText(
                      title: 'Email Address',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.kAppLightBlueColor,
                    ),
                  ],
                ),
                heightBox(8),
                KTextField(
                  controller: auth.registerEmailController,
                  hintText: 'Email',
                  prefixIcon: Icons.contact_mail_outlined,
                ),
                heightBox(16),
                Row(
                  children: [
                    NormalText(
                      title: 'Password',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.kAppLightBlueColor,
                    ),
                  ],
                ),
                heightBox(8),
                KTextField(
                  controller: auth.registerPasswordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: provider.obscureTextLogin
                      ? CupertinoIcons.eye_slash
                      : CupertinoIcons.eye,
                  maxLines: 1,
                  obscureText: provider.obscureTextLogin,
                  onSuffixTap: () => auth.onSuffixLoginTap(),
                ),
                heightBox(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => provider.agreeCheckBoxToggle(),
                      child: Icon(
                        provider.agreeCheckBox
                            ? CupertinoIcons.checkmark_square
                            : CupertinoIcons.square,
                        color: AppColor.kAppYellowColor,
                      ),
                    ),
                    widthBox(10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read & agreed to DayTask ',
                            style: textStyle(
                              color: AppColor.kAppLightBlueColor,
                              fontSize: 10,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy, \nTerms & Condition',
                            style: textStyle(
                              color: AppColor.kAppYellowColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightBox(20),
                ButtonL(
                  title: 'Sign Up',
                  onTap: () {
                    final email = provider.registerEmailController.text.trim();
                    final password =
                        provider.registerPasswordController.text.trim();

                    if (email.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Please enter your email address',
                        backgroundColor: Colors.red,
                      );
                    } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                        .hasMatch(email)) {
                      Fluttertoast.showToast(
                        msg: 'Please enter a valid email address',
                        backgroundColor: Colors.red,
                      );
                    } else if (password.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Please enter your password',
                        backgroundColor: Colors.red,
                      );
                    } else if (password.length < 6) {
                      Fluttertoast.showToast(
                        msg: 'Password must be at least 6 characters',
                        backgroundColor: Colors.red,
                      );
                    } else if (!provider.agreeCheckBox) {
                      Fluttertoast.showToast(
                        msg: 'You must agree to the terms & conditions',
                        backgroundColor: Colors.red,
                      );
                    } else {
                      auth.register(context);
                    }
                  },
                ),
                heightBox(30),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    widthBox(10),
                    NormalText(
                      title: 'Or continue with',
                      color: AppColor.kAppLightBlueColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    widthBox(10),
                    Expanded(child: Divider()),
                  ],
                ),
                heightBox(30),
                IconButtonL(
                  title: 'Google',
                  onTap: () {},
                  isLoading: isLoading,
                  imgPath: 'assets/icons/google.svg',
                ),
                heightBox(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NormalText(
                      title: 'Already have an account? ',
                      color: AppColor.kAppLightBlueColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationClass.pushAndRemoveUntilWithSlideTransition(
                            context: context, page: LoginScreen());
                      },
                      child: NormalText(
                        title: 'Log In',
                        fontSize: 14,
                        color: AppColor.kAppYellowColor,
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

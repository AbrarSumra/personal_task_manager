import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_task_manager/app/app_theme/app_theme.dart';
import 'package:personal_task_manager/app/custom_widget/Icon_button.dart';
import 'package:personal_task_manager/app/custom_widget/button_l.dart';
import 'package:personal_task_manager/app/custom_widget/login_text_field.dart';
import 'package:personal_task_manager/app/custom_widget/text_constant.dart';
import 'package:personal_task_manager/auth/signup_screen.dart';
import 'package:personal_task_manager/utils/shared_preference_helper.dart';
import 'package:provider/provider.dart';
import '../app/custom_widget/navigation_class.dart';
import '../app/custom_widget/widgets.dart';
import '../provider/auth_service_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final auth = Provider.of<AuthServiceProvider>(context, listen: false);
    final savedEmail =
        await SharedPreferencesHelper.getKey(PrefsKeys.loginEmail);
    if (savedEmail != null) {
      auth.loginEmailController.text = savedEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.kAppBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
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
                        title: 'Welcome Back!',
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
                    controller: auth.loginEmailController,
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
                    controller: auth.loginPasswordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outlined,
                    suffixIcon: provider.obscureTextLogin
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    maxLines: 1,
                    obscureText: provider.obscureTextLogin,
                    onSuffixTap: () => auth.onSuffixLoginTap(),
                  ),
                  heightBox(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NormalText(
                        title: 'Forgot Password?',
                        color: AppColor.kAppLightBlueColor,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  heightBox(20),
                  ButtonL(
                    title: 'Log In',
                    onTap: () => provider.login(context),
                    isLoading: provider.isLoading,
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
                    imgPath: 'assets/icons/google.svg',
                  ),
                  heightBox(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalText(
                        title: 'Don’t have an account? ',
                        color: AppColor.kAppLightBlueColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationClass.pushWithSlideTransition(
                              context: context, page: SignUpScreen());
                        },
                        child: NormalText(
                          title: 'Sign Up',
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
      ),
    );
  }
}

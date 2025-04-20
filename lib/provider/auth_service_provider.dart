import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_task_manager/app/custom_widget/navigation_class.dart';
import 'package:personal_task_manager/utils/shared_preference_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/login_screen.dart';
import '../dashboard/dashboard_screen.dart';

class AuthServiceProvider with ChangeNotifier {
  bool obscureTextLogin = true;
  bool agreeCheckBox = false;

  final SupabaseClient _client = Supabase.instance.client;
  Session? session;

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  bool isLoading = false;

  AuthServiceProvider() {
    session = _client.auth.currentSession;
    _client.auth.onAuthStateChange.listen((data) {
      session = data.session;
      notifyListeners();
    });
  }

  bool get isAuthenticated => session != null;

  void onSuffixLoginTap() {
    obscureTextLogin = !obscureTextLogin;
    notifyListeners();
  }

  void agreeCheckBoxToggle() {
    agreeCheckBox = !agreeCheckBox;
    notifyListeners();
  }

  void setLoadingToggle(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    final email = registerEmailController.text.trim();
    final password = registerPasswordController.text.trim();

    setLoadingToggle(true);

    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Registration failed');
      }

      Fluttertoast.showToast(
        msg: 'Registration successful! Please log in.',
        backgroundColor: Colors.green,
      );

      NavigationClass.pushAndRemoveUntilWithSlideTransition(
          context: context, page: LoginScreen());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    } finally {
      setLoadingToggle(false);
    }
  }

  Future<void> login(BuildContext context) async {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text.trim();

    setLoadingToggle(true);

    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password must not be empty');
      }

      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null) {
        throw Exception('Login failed');
      }

      session = response.session;
      loginPasswordController.clear();

      // Save email to SharedPreferences
      await SharedPreferencesHelper.saveKey(PrefsKeys.loginEmail, email);
      await SharedPreferencesHelper.saveKey(
          PrefsKeys.loginSave, session!.tokenType.toString());

      NavigationClass.pushAndRemoveUntilWithSlideTransition(
        context: context,
        page: DashboardScreen(),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: Colors.red,
      );
    } finally {
      setLoadingToggle(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    await _client.auth.signOut();
    session = null;

    SharedPreferencesHelper.removeKey(PrefsKeys.loginSave);

    NavigationClass.pushAndRemoveUntilWithSlideTransition(
        context: context, page: LoginScreen());
    notifyListeners();
  }
}

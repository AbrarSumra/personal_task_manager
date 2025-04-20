import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_task_manager/auth/login_screen.dart';
import 'package:personal_task_manager/dashboard/dashboard_screen.dart';
import 'package:personal_task_manager/provider/auth_service_provider.dart';
import 'package:personal_task_manager/provider/dashboard_provider.dart';
import 'package:personal_task_manager/utils/shared_preference_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

import 'intro_screen/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vtasecsyudjdvdjuzber.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0YXNlY3N5dWRqZHZkanV6YmVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwNDk3MjYsImV4cCI6MjA2MDYyNTcyNn0.WhGkYDiTFvCjgnrM_frAauc-EOFtOz0t614BP1ChfME',
  );

  // for Login Save
  var token = await SharedPreferencesHelper.getKey(PrefsKeys.loginSave);

  Widget initialPage = token != null ? DashboardScreen() : const IntroScreen();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MyApp(initialPage: initialPage),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialPage});
  final Widget initialPage;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 829),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'Abrar Portfolio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            home: initialPage);
      },
    );
  }
}

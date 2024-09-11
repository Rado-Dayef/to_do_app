import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/strings.dart';
import 'package:to_do_app/views/screens/home_screen.dart';
import 'package:to_do_app/views/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: AppColors.transparentColor,
        highlightColor: AppColors.transparentColor,
      ),
      routes: {
        AppStrings.homeRoute: (_) => const HomeScreen(),
        AppStrings.splashRoute: (_) => const SplashScreen(),
      },
      initialRoute: AppStrings.splashRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/extensions.dart';
import 'package:to_do_app/constants/strings.dart';
import 'package:to_do_app/controllers/to_do_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ToDoController toDoController = ToDoController();

  Future<void> _navigateToHome() async {
    await toDoController.getToDos();
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        AppStrings.homeRoute,
        arguments: toDoController,
      );
    }
  }

  @override
  void initState() {
    _navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppStrings.appLogo,
                height: 150,
              ),
              25.gap,
              const Text(
                AppStrings.appTitle,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlueColor,
                ),
              ),
              5.gap,
              Text(
                AppStrings.appSubtitle,
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.darkBlueColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 75,
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.darkBlueColor,
          size: 50,
        ),
      ),
    );
  }
}

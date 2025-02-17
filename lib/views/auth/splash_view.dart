import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_reviewer/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.put(AuthController()).loadUserData();
      Get.offNamed(Get.put(AuthController()).userModel.value == null
          ? Routes.signin
          : Routes.bottomNav);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Transform(
            transform: Matrix4.skewX(-0.15),
            child: const TextWidget(
              text: 'Book Reviewer',
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

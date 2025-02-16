import 'dart:math';

import 'package:book_reviewer/routes/routes.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/views/widgets/loading_widget.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_field_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../controllers/auth_controller.dart';

class SigninView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: authController.isLoading.value,
        progressIndicator: const LoadingWidget(),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splashScreen.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform(
                            transform: Matrix4.skewX(-0.2),
                            child: const TextWidget(
                              text: 'Book Reviewer',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 10.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      padding: const EdgeInsets.all(20),
                      height: context.height * 0.45,
                      width: context.width * 0.9,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Sign In',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blueDark,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextFieldWidget(
                            hint: 'Email',
                            controller: emailController,
                          ),
                          const SizedBox(height: 8),
                          TextFieldWidget(
                            hint: 'Password',
                            controller: passwordController,
                          ),
                          SizedBox(height: context.height * 0.02),
                          ButtonWidget(
                            boxShadowOpacity: 0.3,
                            showElevation: true,
                            width: context.width * 1,
                            color: AppColors.redAccent,
                            borderRadius: 6,
                            text: 'Sign In',
                            fontSize: 20,
                            colorText: Colors.white,
                            onTap: () {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                Get.snackbar(
                                    'Error', 'Please fill in all fields.');
                              } else {
                                authController.signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                              }
                            },
                          ),
                          SizedBox(height: context.height * 0.01),
                          ButtonWidget(
                            boxShadowOpacity: 0.3,
                            showElevation: true,
                            width: context.width * 1,
                            color: Colors.white,
                            borderRadius: 6,
                            onTap: () {
                              authController.signInWithGoogle();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const TextWidget(
                                    text: 'Sign In with Google',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ]),
                          ),
                          SizedBox(height: context.height * 0.03),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.signup);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*
  onPressed: () {
                authController.signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },

*/

import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/loading_widget.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_field_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../controllers/auth_controller.dart';

class SigninView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: false,
      progressIndicator: const LoadingWidget(
        showImageLoading: false,
      ),
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
                    height: context.height * 0.43,
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
                          width: context.width * 1,
                          color: AppColors.redAccent,
                          borderRadius: 6,
                          text: 'Sign In',
                          fontSize: 20,
                          colorText: Colors.white,
                          onTap: () {
                            authController.signIn(emailController.text.trim(),
                                passwordController.text.trim());
                          },
                        ),
                        SizedBox(height: context.height * 0.02),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                                height: 20,
                                thickness: 1,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            ButtonWidget(
                              width: 0,
                              height: 0,
                              color: Colors.white,
                              borderRadius: 6,
                              onTap: () {},
                              child: Image.asset(
                                'assets/icons/facebook.png',
                                height: 21,
                                width: 21,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            ButtonWidget(
                              width: 0,
                              height: 0,
                              color: Colors.white,
                              borderRadius: 6,
                              onTap: () {},
                              child: Image.asset(
                                'assets/icons/google.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                                height: 20,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.height * 0.02),
                        const Row(
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationThickness: 2,
                              ),
                            ),
                          ],
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

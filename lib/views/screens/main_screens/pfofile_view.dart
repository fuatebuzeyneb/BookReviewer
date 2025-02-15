import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    print("UserModel after loading: ${_authController.userModel.value!.email}");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextWidget(
          text: 'Book Reviewer',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
        child: SizedBox(
          width: context.width * 1,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.yellow,
                radius: 55, // نصف قطر الدائرة
                child: CircleAvatar(
                    radius: 50, // نصف قطر الدائرة
                    backgroundImage: NetworkImage(
                      _authController.userModel.value!.profilePicture!,
                    )),
              ),
              SizedBox(height: context.height * 0.02),
              Container(
                padding: const EdgeInsets.all(6),
                height: context.height * 0.07,
                width: context.width * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: 'Name & Surname',
                            fontSize: 12,
                          ),
                          TextWidget(
                            text: _authController.userModel.value!.fullName!,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ])
                  ]),
                ),
              ),
              SizedBox(height: context.height * 0.01),
              Container(
                padding: const EdgeInsets.all(6),
                height: context.height * 0.07,
                width: context.width * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: 'Email',
                            fontSize: 12,
                          ),
                          TextWidget(
                            text: _authController.userModel.value!.email,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ])
                  ]),
                ),
              ),
              SizedBox(height: context.height * 0.01),
              Container(
                padding: const EdgeInsets.all(6),
                height: context.height * 0.07,
                width: context.width * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: 'Created At',
                            fontSize: 12,
                          ),
                          TextWidget(
                            text: _authController.userModel.value!.createdAt,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ])
                  ]),
                ),
              ),
              SizedBox(height: context.height * 0.01),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.myBooksView);
                  Get.find<BookController>()
                      .loadUserBooks(_authController.userModel.value!.uid);
                  // Get.find<BookController>().loadBooks();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: context.height * 0.07,
                  width: context.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: TextWidget(
                        text: 'My Books',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.01),
              ButtonWidget(
                onTap: () {
                  _authController.signOut();
                },
                text: 'Logout',
                height: 0.06,
                width: 0.9,
                colorText: Colors.white,
                fontSize: 18,
                color: AppColors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

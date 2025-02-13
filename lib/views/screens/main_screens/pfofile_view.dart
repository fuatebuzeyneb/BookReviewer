import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: const CircleAvatar(
                  radius: 50, // نصف قطر الدائرة
                  backgroundImage:
                      AssetImage('assets/images/test_book.jpg'), // رابط الصورة
                ),
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: 'Name & Surname',
                            fontSize: 12,
                          ),
                          TextWidget(
                            text: 'Toon Maryon',
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: 'Email',
                            fontSize: 12,
                          ),
                          TextWidget(
                            text: 'Toon Maryon',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ])
                  ]),
                ),
              ),
              SizedBox(height: context.height * 0.01),
              ButtonWidget(
                onTap: () {},
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

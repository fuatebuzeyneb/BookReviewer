import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: context.height * 0.32,
                width: context.width * 1,
                decoration: BoxDecoration(
                  color: AppColors.blueDark,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/test_book.jpg',
                        height: context.height * 0.2,
                        width: context.width * 0.2,
                      ),
                      SizedBox(width: context.width * 0.05),
                      Expanded(
                        // تأكد من أن النص يتمدد ويأخذ المساحة المتاحة
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: 'fdgdf fgdfg',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 2),
                            const TextWidget(
                              text:
                                  'This is a long text that will wrap into multiple different lines depending on the width of the screen or container.',
                              fontSize: 12,
                              textAlign: TextAlign.left,
                              maxLines: 2, // عرض النص على 3 أسطر كحد أقصى
                              isHaveOverflow: true, // للتأكد من التفاف النص
                              color: Colors.white,
                            ),
                            const SizedBox(height: 2),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                    text: 'Author:  ',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  TextWidget(
                                    text: 'Toon Maryon',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.greenAccent,
                                  ),
                                ]),
                            const SizedBox(height: 2),
                            const Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                TextWidget(
                                  text: '4.5',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
              Positioned(
                left: (context.width * 0.1) / 2,
                bottom: -32,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: context.height * 0.1,
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
                      CircleAvatar(
                        radius: 30, // نصف قطر الدائرة
                        backgroundImage: AssetImage(
                            'assets/images/test_book.jpg'), // رابط الصورة
                      ),
                      SizedBox(width: 12),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: 'Publish By',
                              fontSize: 12,
                            ),
                            TextWidget(
                              text: 'Toon Maryon',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            TextWidget(
                              text: 'Publish Date: 23.12.2023',
                              fontSize: 10,
                            ),
                          ])
                    ]),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 36,
                child: GestureDetector(
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                    onTap: () {
                      Get.back();
                    }),
              )
            ],
          ),
          SizedBox(height: context.height * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Row(
                  children: [
                    TextWidget(
                      text: 'About The Book',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const TextWidget(
                  text:
                      ''''The Psychology of Money' is an essential read for anyone interested in being better with money. Fast-paced and engaging, this book will help you refine your thoughts towards money. You can finish this book in a week, unlike other books that are too lengthy.

The most important emotions in relation to money are fear, guilt, shame, and envy. It's worth spending some effort to become aware of the emotions that are especially tied to money for you because, without awareness, they will tend to override rational thinking and drive your actions.''',
                  fontSize: 12,
                  textAlign: TextAlign.left,
                  maxLines: 12, // عرض النص على 12 سطر كحد أقصى
                  isHaveOverflow: true, // للتأكد من التفاف النص
                  color: Colors.black54,
                ),
                SizedBox(height: context.height * 0.03),
                const Row(
                  children: [
                    TextWidget(
                      text: 'Reviews & Comments',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

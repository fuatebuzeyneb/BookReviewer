import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
//Top Rating
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ButtonWidget(
                  showElevation: true,
                  borderRadius: 20,
                  height: 0.225,
                  width: 1,
                  color: Colors.white,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/test_book.jpg',
                          height: context.height * 0.24,
                          width: context.width * 0.24,
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
                              ),
                              const SizedBox(height: 4),
                              const TextWidget(
                                text:
                                    'This is a long text that will wrap into multiple lines depending on the width of the screen or container.',
                                fontSize: 12,
                                textAlign: TextAlign.left,
                                maxLines: 3, // عرض النص على 3 أسطر كحد أقصى
                                isHaveOverflow: true, // للتأكد من التفاف النص
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  ButtonWidget(
                                    onTap: () {},
                                    text: 'dsfsd fsdf',
                                    fontSize: 14,
                                    color: AppColors.redAccent,
                                    colorText: Colors.white,
                                    borderRadius: 6,
                                    paddingHorizontal: 25,
                                    paddingVertical: 8,
                                    height: 0,
                                    width: 0,
                                  ),
                                  const SizedBox(width: 6),
                                  ButtonWidget(
                                    onTap: () {},
                                    text: 'dsfsd fsdf',
                                    fontSize: 14,
                                    colorText: Colors.black,
                                    borderRadius: 20,
                                    paddingHorizontal: 20,
                                    paddingVertical: 10,
                                    height: 0,
                                    width: 0,
                                  )
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
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        TextWidget(
                          text: 'Top Rating (4.8)',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.redAccent,
                        ),
                      ],
                    )),
              ],
            ),
            const Row(
              children: [
                TextWidget(
                  text: 'Popular books',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const Row(
              children: [
                TextWidget(
                  text: 'Last books',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ButtonWidget(
                    showElevation: true,
                    borderRadius: 20,
                    height: 0.18,
                    width: 1,
                    color: Colors.white,
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/test_book.jpg',
                            height: context.height * 0.15,
                            width: context.width * 0.15,
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
                                ),
                                const SizedBox(height: 4),
                                const TextWidget(
                                  text:
                                      'This is a long text that will wrap into multiple lines depending on the width of the screen or container.',
                                  fontSize: 12,
                                  textAlign: TextAlign.left,
                                  maxLines: 3, // عرض النص على 3 أسطر كحد أقصى
                                  isHaveOverflow: true, // للتأكد من التفاف النص
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    ButtonWidget(
                                      onTap: () {},
                                      text: 'dsfsd fsdf',
                                      fontSize: 14,
                                      color: AppColors.redAccent,
                                      colorText: Colors.white,
                                      borderRadius: 6,
                                      paddingHorizontal: 25,
                                      paddingVertical: 8,
                                      height: 0,
                                      width: 0,
                                    ),
                                    const SizedBox(width: 6),
                                    ButtonWidget(
                                      onTap: () {},
                                      text: 'dsfsd fsdf',
                                      fontSize: 14,
                                      colorText: Colors.black,
                                      borderRadius: 20,
                                      paddingHorizontal: 20,
                                      paddingVertical: 10,
                                      height: 0,
                                      width: 0,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

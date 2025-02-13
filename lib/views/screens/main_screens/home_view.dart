import 'package:book_reviewer/routes/routes.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
//Top Rating
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  borderRadius: 12,
                  height: 0.18,
                  width: 1,
                  color: Colors.white,
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              ),
                              const SizedBox(height: 2),
                              const TextWidget(
                                text:
                                    'This is a long text that will wrap into multiple lines depending on the width of the screen or container.',
                                fontSize: 12,
                                textAlign: TextAlign.left,
                                maxLines: 3, // عرض النص على 3 أسطر كحد أقصى
                                isHaveOverflow: true, // للتأكد من التفاف النص
                              ),
                              const SizedBox(height: 2),
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
            const SizedBox(height: 8),
            const Row(
              children: [
                TextWidget(
                  text: 'Popular books',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: context.height * 0.14,
              width: context.width * 1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8), // توسيع المسافة بين الصور
                    child: Image.asset(
                      'assets/images/test_book.jpg',
                      height: context.height * 0.14,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                TextWidget(
                  text: 'Last books',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 6, left: 6, right: 6),
                    child: ButtonWidget(
                      showElevation: true,
                      borderRadius: 12,
                      height: 0.12,
                      width: 1,
                      color: Colors.white,
                      onTap: () {
                        Get.toNamed(Routes.bookDetailsView);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/test_book.jpg',
                              height: context.height * 0.1,
                              width: context.width * 0.14,
                            ),
                            SizedBox(width: context.width * 0.03),
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
                                  const SizedBox(height: 2),
                                  TextWidget(
                                    text: 'Author:  fdgdf fgdfg',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blueDark,
                                  ),
                                  const SizedBox(height: 2),
                                  const Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ButtonWidget(
                                  onTap: () {},
                                  text: 'dsfsd fsdf',
                                  fontSize: 14,
                                  color: AppColors.redAccent,
                                  colorText: Colors.white,
                                  borderRadius: 6,
                                  paddingHorizontal: 14,
                                  paddingVertical: 6,
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
                                  paddingHorizontal: 10,
                                  paddingVertical: 6,
                                  height: 0,
                                  width: 0,
                                )
                              ],
                            )
                          ],
                        ),
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

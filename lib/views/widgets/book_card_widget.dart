import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/controllers/comment_controller.dart';
import 'package:book_reviewer/models/book_model.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class bookCardWidget extends StatelessWidget {
  const bookCardWidget({
    super.key,
    required this.books,
    required this.index,
  });

  final RxList<BookModel> books;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 6, right: 6),
      child: ButtonWidget(
        showElevation: true,
        borderRadius: 6,
        height: 0.12,
        width: 1,
        color: Colors.white,
        onTap: () {
          // Get.toNamed(Routes.bookDetailsView);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                books[index].coverImageUrl,
                height: context.height * 0.1,
                width: context.width * 0.14,
              ),
              SizedBox(width: context.width * 0.03),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      textAlign: TextAlign.left,
                      isHaveOverflow: true,
                      maxLines: 1,
                      text: books[index].title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        TextWidget(
                          text: 'Author: ',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueDark,
                        ),
                        TextWidget(
                          text: books[index].author,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greenAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          TextWidget(
                            text: books[index].rating.toStringAsFixed(1),
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ]),
                        Column(children: [
                          ButtonWidget(
                            onTap: () {
                              // Get.find<CommentController>().fetchUserComment(
                              //     bookId: books[index].id,
                              //     userId: Get.find<AuthController>()
                              //         .userModel
                              //         .value!
                              //         .uid);
                              Get.find<BookController>()
                                  .loadBookById(books[index].id);
                              Get.toNamed(Routes.bookDetailsView);
                            },
                            text: 'Lear More',
                            fontSize: 14,
                            color: AppColors.redAccent,
                            colorText: Colors.white,
                            borderRadius: 6,
                            paddingHorizontal: 14,
                            paddingVertical: 6,
                            height: 0,
                            width: 0,
                          ),
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

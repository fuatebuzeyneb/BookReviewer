import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/controllers/comment_controller.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/add_comment_and_rate_widget.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/loading_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BookDetailsView extends StatelessWidget {
  final BookController bookController = Get.find<BookController>();
  final AuthController authController = Get.find<AuthController>();
  final CommentController commentController = Get.find<CommentController>();

  BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: commentController.isLoading.value ||
              bookController.isLoading.value ||
              authController.isLoading.value ||
              bookController.selectedBook == null,
          progressIndicator: const LoadingWidget(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.grey[100],
            body: SingleChildScrollView(
              child: Column(
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
                              Image.network(
                                bookController.selectedBook!.coverImageUrl,
                                height: context.height * 0.17,
                                width: context.width * 0.2,
                              ),
                              SizedBox(width: context.width * 0.05),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: bookController.selectedBook!.title,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 2),
                                    TextWidget(
                                      text: bookController
                                          .selectedBook!.description,
                                      fontSize: 12,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      isHaveOverflow: true,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const TextWidget(
                                            text: 'Author:  ',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          TextWidget(
                                            text: bookController
                                                .selectedBook!.author,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.greenAccent,
                                          ),
                                        ]),
                                    const SizedBox(height: 2),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow.shade700,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        TextWidget(
                                          text: bookController
                                              .selectedBook!.rating
                                              .toStringAsFixed(1),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(children: [
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage: NetworkImage(bookController
                                      .selectedBook!.publisherImageUrl)),
                              const SizedBox(width: 12),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextWidget(
                                      text: 'Publish By',
                                      fontSize: 12,
                                    ),
                                    TextWidget(
                                      text: bookController
                                          .selectedBook!.publisherName,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextWidget(
                                      text:
                                          'Publish Date: ${DateFormat('dd.MM.yyyy').format(bookController.selectedBook!.createdAt)}',
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
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onTap: () {
                              Get.back();
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: context.height * 0.05),
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
                        TextWidget(
                          text: bookController.selectedBook!.description,
                          fontSize: 12,
                          textAlign: TextAlign.justify,
                          maxLines: 12,
                          isHaveOverflow: true,
                          color: Colors.black54,
                        ),
                        SizedBox(height: context.height * 0.015),
                        const Row(
                          children: [
                            TextWidget(
                              text: 'Reviews & Comments',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: context.height * 0.01),
                        bookController.selectedBook!.userId ==
                                authController.userModel.value!.uid
                            ? const SizedBox()
                            : ButtonWidget(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    builder: (context) {
                                      return const AddCommentAndRateWidget(
                                        itIsEdit: false,
                                      );
                                    },
                                  );
                                },
                                height: 0.05,
                                width: 1,
                                color: AppColors.greenAccent,
                                text: 'Add Review',
                                fontSize: 16,
                              ),
                        SizedBox(height: context.height * 0.02),
                        SizedBox(
                          height: context.height * 0.27,
                          width: context.width * 1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                bookController.selectedBook!.comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ButtonWidget(
                                  onTap: () {},
                                  color: Colors.white,
                                  height: 0.25,
                                  width: 0.55,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8, bottom: 4),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    bookController
                                                        .selectedBook!
                                                        .comments[index]
                                                        .userImageUrl)),
                                            const SizedBox(width: 12),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextWidget(
                                                    text: bookController
                                                        .selectedBook!
                                                        .publisherName,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        'Publish Date: ${DateFormat('dd.MM.yyyy').format(bookController.selectedBook!.comments[index].createdAt)}',
                                                    fontSize: 10,
                                                  ),
                                                ]),
                                          ]),
                                          const SizedBox(height: 8),
                                          RatingBarIndicator(
                                            rating: bookController.selectedBook!
                                                .comments[index].ratingValue,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 25.0,
                                            unratedColor: Colors.grey.shade300,
                                            direction: Axis.horizontal,
                                          ),
                                          const SizedBox(height: 10),
                                          TextWidget(
                                            text: bookController.selectedBook!
                                                .comments[index].commentText,
                                            fontSize: 10,
                                            textAlign: TextAlign.justify,
                                            maxLines: 7,
                                            isHaveOverflow: true,
                                            color: Colors.black54,
                                          ),
                                          const Spacer(),
                                          bookController.selectedBook!
                                                      .comments[index].userId ==
                                                  authController
                                                      .userModel.value!.uid
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                      ButtonWidget(
                                                        borderRadius: 6,
                                                        paddingHorizontal: 36,
                                                        paddingVertical: 6,
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            enableDrag: false,
                                                            builder: (context) {
                                                              return AddCommentAndRateWidget(
                                                                  itIsEdit:
                                                                      true,
                                                                  index: index);
                                                            },
                                                          );
                                                        },
                                                        height: 0,
                                                        width: 0,
                                                        color: AppColors
                                                            .greenAccent,
                                                        child: const Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                            size: 18),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      ButtonWidget(
                                                        onTap: () async {
                                                          commentController
                                                              .deleteComment(
                                                                  bookId: bookController
                                                                      .selectedBook!
                                                                      .id,
                                                                  index: index);
                                                          await bookController
                                                              .loadBookById(
                                                                  bookController
                                                                      .selectedBook!
                                                                      .id);
                                                        },
                                                        borderRadius: 4,
                                                        paddingHorizontal: 36,
                                                        paddingVertical: 6,
                                                        height: 0,
                                                        width: 0,
                                                        color:
                                                            AppColors.redAccent,
                                                        child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                            size: 18),
                                                      )
                                                    ])
                                              : const SizedBox(),
                                        ]),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

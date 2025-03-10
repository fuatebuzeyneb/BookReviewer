import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:book_reviewer/utils/app_colors.dart';
import 'package:book_reviewer/views/books/book_details_view.dart';
import 'package:book_reviewer/views/widgets/books/book_card_widget.dart';
import 'package:book_reviewer/views/widgets/shared/button_widget.dart';
import 'package:book_reviewer/views/widgets/shared/loading_widget.dart';
import 'package:book_reviewer/views/widgets/shared/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyBooksView extends StatelessWidget {
  final BookController bookController = Get.find<BookController>();
  MyBooksView({super.key});

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
            text: 'My Books',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        body: Obx(() {
          return ModalProgressHUD(
            inAsyncCall: bookController.isLoading.value,
            progressIndicator: const LoadingWidget(),
            child: bookController.userBooks.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: 'No Books Yet',
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  )
                : ListView.builder(
                    itemCount: bookController.userBooks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            bookCardWidget(
                                books: bookController.userBooks, index: index),
                            Positioned(
                              top: -12,
                              right: 26,
                              child: Row(children: [
                                ButtonWidget(
                                  borderRadius: 20,
                                  paddingHorizontal: 6,
                                  paddingVertical: 6,
                                  onTap: () {
                                    Get.toNamed(Routes.addBookView,
                                        arguments: {'index': index});
                                  },
                                  height: 0,
                                  width: 0,
                                  color: AppColors.greenAccent,
                                  child: const Icon(Icons.edit,
                                      color: Colors.white, size: 18),
                                ),
                                const SizedBox(width: 8),
                                ButtonWidget(
                                  onTap: () {
                                    bookController.deleteBook(
                                        bookController.userBooks[index].id,
                                        bookController.userBooks[index].userId);
                                  },
                                  borderRadius: 20,
                                  paddingHorizontal: 6,
                                  paddingVertical: 6,
                                  height: 0,
                                  width: 0,
                                  color: AppColors.redAccent,
                                  child: const Icon(Icons.delete,
                                      color: Colors.white, size: 18),
                                )
                              ]),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          );
        }));
  }
}

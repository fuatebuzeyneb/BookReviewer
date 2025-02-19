import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/views/widgets/books/book_card_widget.dart';
import 'package:book_reviewer/views/widgets/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBooksView extends StatelessWidget {
  final BookController controller = Get.put(BookController());

  AllBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.books.length);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextWidget(
          text: 'All Books',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Obx(() => ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.books.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.books.length) {
                return bookCardWidget(books: controller.books, index: index);
              } else {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }
            },
          )),
    );
  }
}

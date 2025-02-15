import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/views/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksPage extends StatelessWidget {
  final BookController controller = Get.put(BookController());

  BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الكتب")),
      body: Obx(() => ListView.builder(
            controller: controller.scrollController, // ربط الـ ScrollController
            itemCount: controller.books.length + 1, // إضافة عنصر اللودينغ
            itemBuilder: (context, index) {
              if (index < controller.books.length) {
                return bookCardWidget(books: controller.books, index: index);
              } else {
                return controller.isLoading.value
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // عرض اللودينغ عند تحميل المزيد
                    : const SizedBox(); // لا شيء عند انتهاء البيانات
              }
            },
          )),
    );
  }
}

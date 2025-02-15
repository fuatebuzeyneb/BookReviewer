import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class MyBooksView extends StatelessWidget {
  final BookController bookController = Get.find<BookController>();
  MyBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Books'),
        ),
        body: Obx(() {
          return bookController.userBooks.isEmpty
              ? const Center(child: Text("لا توجد كتب بعد"))
              : ListView.builder(
                  itemCount: bookController.userBooks.length,
                  itemBuilder: (context, index) {
                    final book = bookController.userBooks[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text("المؤلف: ${book.author}"),
                      leading: Image.network(book.coverImageUrl),
                    );
                  },
                );
        }));
  }
}

import 'package:book_reviewer/models/book_model.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TopRatingBooksWidget extends StatelessWidget {
  final RxList<BookModel> books;
  const TopRatingBooksWidget({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // استخدام Obx لتحديث واجهة المستخدم عند تغيير books
      return SizedBox(
        height: context.height * 0.24,
        width: context.width * 1,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: context.height * 0.24,
                width: context.width * 0.32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(books[index].coverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

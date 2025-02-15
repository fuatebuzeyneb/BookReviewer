import 'package:book_reviewer/models/book_model.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/book_card_widget.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class latestBooksWidget extends StatelessWidget {
  final RxList<BookModel> books;
  const latestBooksWidget({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          itemCount: books.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return bookCardWidget(books: books, index: index);
          },
        ),
      );
    });
  }
}

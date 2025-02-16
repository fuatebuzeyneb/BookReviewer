import 'package:book_reviewer/models/book_model.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
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
              child: Stack(
                children: [
                  Container(
                    height: context.height * 0.24,
                    width: context.width * 0.32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(books[index].coverImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 2,
                      left: 2,
                      child: ButtonWidget(
                        color: Colors.white,
                        showElevation: true,
                        borderRadius: 4,
                        paddingHorizontal: 2,
                        height: 0,
                        width: 0,
                        onTap: () {},
                        child: Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                            size: 16,
                          ),
                          SizedBox(
                            width: context.width * 0.005,
                          ),
                          TextWidget(
                            text: books[index].rating.toStringAsFixed(1),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        ]),
                      ))
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/controllers/comment_controller.dart';
import 'package:book_reviewer/models/comment_model.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/bottom_sheet_widget.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_field_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class AddCommentAndRateWidget extends StatefulWidget {
  const AddCommentAndRateWidget({super.key});

  @override
  _AddCommentAndRateWidgetState createState() =>
      _AddCommentAndRateWidgetState();
}

class _AddCommentAndRateWidgetState extends State<AddCommentAndRateWidget> {
  final ValueNotifier<double> ratingNotifier = ValueNotifier(3.0);
  final FocusNode focusNode = FocusNode();
  final TextEditingController textCommentController = TextEditingController();
  double bottomSheetHeight = 0.4;
  final CommentController commentController = Get.find<CommentController>();
  final BookController bookController = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery بدلاً من KeyboardVisibilityBuilder
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // تحديث ارتفاع الـ BottomSheet بناءً على حالة لوحة المفاتيح
    if (isKeyboardVisible != (bottomSheetHeight > 0.4)) {
      setState(() {
        bottomSheetHeight = isKeyboardVisible ? 0.7 : 0.4;
      });
    }

    return BottomSheetWidget(
      circularRadius: 12,
      height: bottomSheetHeight,
      widgetBody: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: context.width * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const TextWidget(
              text: 'Add Comment and Rate',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 32,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingNotifier.value = rating;
                  },
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<double>(
                  valueListenable: ratingNotifier,
                  builder: (context, rating, _) {
                    return TextWidget(
                      text: 'Rate: (${rating.toString()})',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: textCommentController,
              hint: 'Enter your comment',
              maxLines: 4,
              borderRadius: 12,
              paddingVertical: 12,
            ),
            isKeyboardVisible
                ? const SizedBox(
                    height: 12,
                  )
                : const Spacer(),
            ButtonWidget(
                paddingHorizontal: 12,
                paddingVertical: 8,
                onTap: () {
                  commentController.addComment(
                      bookId: bookController.selectedBook!.id,
                      comment: CommentModel(
                        commentText: textCommentController.text,
                        userId: bookController.selectedBook!.userId,
                        userName: bookController.selectedBook!.publisherName,
                        ratingValue: ratingNotifier.value,
                        userImageUrl:
                            bookController.selectedBook!.publisherImageUrl,
                        createdAt: DateTime.now(),
                      ));
                  FocusScope.of(context).unfocus();
                },
                text: 'Send',
                color: AppColors.blueDark,
                colorText: Colors.white,
                borderColor: AppColors.blueDark,
                borderRadius: 8,
                fontSize: 18,
                width: 1,
                height: 0.055),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

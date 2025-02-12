import 'dart:math';

import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.showImageLoading = true});
  final bool showImageLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: const EdgeInsets.all(0),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Container(
            width: context.width * 0.15,
            height: context.width * 0.15,
            alignment: Alignment.center, // التوسيط
            child: showImageLoading == false
                ? CircularProgressIndicator(
                    color: AppColors.blueDark,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.blueDark,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextWidget(
                        text: 'Loading...',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueDark,
                      )
                    ],
                  ),
          ),
        ),
        SizedBox(
          height: context.height * 0.03,
        ),
      ],
    );
  }
}

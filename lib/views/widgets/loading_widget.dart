import 'package:book_reviewer/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(260.0),
        ),
        color: AppColors.blueDark,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          'assets/icons/loading_icon.gif',
          height: 120,
          width: 120,
        ),
      ),
    );
  }
}

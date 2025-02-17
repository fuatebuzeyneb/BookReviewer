import 'package:book_reviewer/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 12,
      this.fontWeight,
      this.textAlign = TextAlign.center,
      this.isHaveOverflow = false,
      this.isHaveUnderline = false,
      this.maxLines});
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final bool isHaveOverflow;
  final bool isHaveUnderline;

  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: isHaveUnderline == true
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationThickness: 2,
          decorationColor: AppColors.greenAccent),
      textAlign: textAlign!,
      overflow: isHaveOverflow == true ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
    );
  }
}

import 'package:book_reviewer/utils/extensions.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      this.height = 0.06,
      this.width = 0.3,
      required this.onTap,
      this.child,
      this.color = Colors.transparent,
      this.borderRadius = 8,
      this.text = 'Text',
      this.fontSize = 12,
      this.colorText = Colors.white,
      this.borderColor = Colors.transparent,
      this.paddingHorizontal = 0,
      this.paddingVertical = 0,
      this.showElevation = false,
      this.boxShadowOpacity = 0.1});

  final double height;
  final double width;
  final Function() onTap;
  final Color color;
  final Widget? child;
  final double borderRadius;
  final String? text;
  final double? fontSize;
  final Color? colorText;
  final Color borderColor;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final bool? showElevation;
  final double? boxShadowOpacity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal!,
              vertical: paddingVertical!), // padding(value),
          height: height == 0 ? null : context.height * height,
          width: width == 0 ? null : context.width * width,
          decoration: BoxDecoration(
            boxShadow: showElevation == false
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(boxShadowOpacity!),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
            borderRadius: BorderRadius.circular(borderRadius),
            color: color,
            border: Border.all(color: borderColor, width: 1),
          ),
          child: child ??
              Center(
                child: TextWidget(
                  //   fontFamily: 'Tajawal',
                  text: text!,
                  color: colorText!,
                  fontSize: fontSize!,
                  fontWeight: FontWeight.bold,
                ),
              )),
    );
  }
}

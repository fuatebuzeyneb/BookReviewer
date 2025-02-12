import 'package:book_reviewer/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hint,
    this.controller,
    this.keyboardType,
    this.initialValue,
    this.prefixIcon,
    this.borderRadius = 6,
    this.paddingVertical = 14.0,
    this.maxLines = 1,
    this.suffixWidget,
  });

  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final Widget? prefixIcon;
  final double? borderRadius;
  final double? paddingVertical;
  final int? maxLines;
  final Widget? suffixWidget;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: AppColors.blueDark,
      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        prefixIcon: prefixIcon,
        contentPadding:
            EdgeInsets.symmetric(vertical: paddingVertical!, horizontal: 12.0),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Tajawal'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: AppColors.yellow, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
      ),
    );
  }
}

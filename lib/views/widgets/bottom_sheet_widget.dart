import 'package:book_reviewer/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.height,
    this.widgetBody,
    this.color = Colors.white,
    this.padding = 8,
    this.circularRadius,
    this.enableDrag = false,
  });
  final double height;

  final Widget? widgetBody;

  final double? padding;

  final double? circularRadius;

  final Color? color;
  final bool? enableDrag;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: enableDrag!,
      onClosing: () {
        //  Navigator.pop(context);
      },
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(circularRadius ?? 0),
                topRight: Radius.circular(circularRadius ?? 0)),
            color: color!,
          ),
          height: context.height * height,
          child: Padding(
            padding: EdgeInsets.all(padding!),
            child: widgetBody,
          ),
        );
      },
    );
  }
}

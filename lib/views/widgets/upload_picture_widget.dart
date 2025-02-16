import 'dart:io';

import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadPictureWidget extends StatefulWidget {
  final String? imageUrl;
  final int witchType;
  const UploadPictureWidget(
      {super.key, required this.witchType, this.imageUrl});

  @override
  _UploadPictureWidgetState createState() => _UploadPictureWidgetState();
}

class _UploadPictureWidgetState extends State<UploadPictureWidget> {
  String? _imagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        if (widget.witchType == 2) {
          Get.find<AuthController>().pickedImage.value = File(_imagePath!);
        } else if (widget.witchType == 1) {
          Get.find<BookController>().pickedImage.value = File(_imagePath!);
        }
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _imagePath = null;
      if (widget.witchType == 2) {
        Get.find<AuthController>().pickedImage.value = null;
      } else if (widget.witchType == 1) {
        Get.find<BookController>().pickedImage.value = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ButtonWidget(
          onTap: () {},
          width: 0.28,
          height: widget.witchType == 2 ? 0.12 : 0.18,
          color: Colors.transparent,
          borderColor: Colors.grey,
          borderRadius: 6,
          colorText: Colors.white,
          child: _imagePath != null
              ? Image.file(
                  File(_imagePath!),
                  fit: BoxFit.cover,
                )
              : widget.imageUrl != null
                  ? Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image, color: Colors.grey, size: 30),
        ),
        Positioned(
            top: -10,
            right: -10,
            child: ButtonWidget(
              onTap: () async {
                if (_imagePath == null) {
                  await _pickImage();
                } else {
                  _deleteImage();
                }
              },
              color: AppColors.greenAccent,
              height: 0.035,
              width: 0.07,
              borderRadius: 16,
              child: Icon(
                _imagePath == null ? Icons.camera : Icons.delete,
                color: Colors.black,
                size: 20,
              ),
            )),
      ],
    );
  }
}

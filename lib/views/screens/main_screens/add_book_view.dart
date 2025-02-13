import 'package:book_reviewer/themes/app_colors.dart';
import 'package:book_reviewer/themes/extensions.dart';
import 'package:book_reviewer/views/widgets/button_widget.dart';
import 'package:book_reviewer/views/widgets/text_field_widget.dart';
import 'package:book_reviewer/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AddBookView extends StatelessWidget {
  AddBookView({super.key});
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextWidget(
          text: 'Add Book',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: SizedBox(
        width: context.width * 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 16.0), // padding(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ButtonWidget(
                    onTap: () {},
                    text: 'Book Cover',
                    height: 0.18,
                    width: 0.28,
                    borderColor: Colors.grey,
                    colorText: Colors.black,
                    fontSize: 14,
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: ButtonWidget(
                      onTap: () {},
                      color: AppColors.greenAccent,
                      height: 0.035,
                      width: 0.07,
                      borderRadius: 16,
                      child: const Icon(Icons.camera,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                hint: 'Book Name',
                controller: bookNameController,
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                hint: 'Author Name',
                controller: authorNameController,
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                maxLines: 8,
                hint: 'Description',
                controller: descriptionController,
              ),
              SizedBox(height: context.height * 0.04),
              ButtonWidget(
                onTap: () {},
                text: 'Add Book',
                height: 0.06,
                width: 0.7,
                colorText: Colors.white,
                fontSize: 14,
                color: AppColors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

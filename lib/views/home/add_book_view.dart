import 'dart:math';

import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/models/book_model.dart';
import 'package:book_reviewer/utils/app_colors.dart';
import 'package:book_reviewer/utils/extensions.dart';
import 'package:book_reviewer/views/widgets/shared/button_widget.dart';
import 'package:book_reviewer/views/widgets/shared/loading_widget.dart';
import 'package:book_reviewer/views/widgets/shared/text_field_widget.dart';
import 'package:book_reviewer/views/widgets/shared/text_widget.dart';
import 'package:book_reviewer/views/widgets/shared/upload_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddBookView extends StatelessWidget {
  final bool? itIsEdit;
  AddBookView({super.key, this.itIsEdit = false});

  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final BookController bookController = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    if (itIsEdit == true) {
      int index = Get.arguments['index'];
      bookNameController.text = bookController.userBooks[index].title;
      authorNameController.text = bookController.userBooks[index].author;
      descriptionController.text = bookController.userBooks[index].description;
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextWidget(
          text: itIsEdit == true ? 'Edit Book' : 'Add Book',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: bookController.isLoading.value,
          progressIndicator: const LoadingWidget(),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UploadPictureWidget(
                      imageUrl: itIsEdit == false
                          ? null
                          : bookController
                              .userBooks[Get.arguments['index']].coverImageUrl,
                      witchType: 1,
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
                      onTap: () {
                        if (itIsEdit == false) {
                          if (bookNameController.text.isEmpty ||
                              authorNameController.text.isEmpty ||
                              descriptionController.text.isEmpty ||
                              bookController.pickedImage.value == null) {
                            Get.snackbar('Error', 'Please fill all the fields');
                          } else {
                            bookController.addBook(
                              title: bookNameController.text,
                              author: authorNameController.text,
                              description: descriptionController.text,
                              publisherName: Get.find<AuthController>()
                                  .userModel
                                  .value!
                                  .fullName!,
                              publisherImageUrl: Get.find<AuthController>()
                                  .userModel
                                  .value!
                                  .profilePicture!,
                              coverImageUrl:
                                  bookController.pickedImage.value.toString(),
                            );
                          }
                        } else {
                          bookController.editBook(
                              updatedBook: BookModel(
                            title: bookNameController.text,
                            author: authorNameController.text,
                            description: descriptionController.text,
                            id: bookController
                                .userBooks[Get.arguments['index']].id,
                            coverImageUrl:
                                bookController.pickedImage.value.toString(),
                            userId: bookController
                                .userBooks[Get.arguments['index']].userId,
                            rating: bookController
                                .userBooks[Get.arguments['index']].rating,
                            comments: bookController
                                .userBooks[Get.arguments['index']].comments,
                            createdAt: bookController
                                .userBooks[Get.arguments['index']].createdAt,
                            publisherName: bookController
                                .userBooks[Get.arguments['index']]
                                .publisherName,
                            publisherImageUrl: bookController
                                .userBooks[Get.arguments['index']]
                                .publisherImageUrl,
                          ));
                        }
                      },
                      text: itIsEdit == true ? 'Edit Book' : 'Add Book',
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
          ),
        ),
      ),
    );
  }
}

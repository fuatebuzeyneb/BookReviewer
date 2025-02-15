import 'dart:io';

import 'package:book_reviewer/models/comment_model.dart';
import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  final BookService _bookService = BookService();

  Rx<File?> pickedImage = Rx<File?>(null);

  // إضافة كتاب جديد
  Future<void> addBook({
    required String title,
    required String author,
    required String description,
    required String coverImageUrl,
  }) async {
    try {
      BookModel book = BookModel(
        id: '',
        title: title,
        author: author,
        description: description,
        coverImageUrl: coverImageUrl,
        userId: '', // سيتم تعبئة هذا الحقل في BookService
        rating: 5.0, // تقييم افتراضي
        comments: [], // قائمة تعليقات فارغة
        createdAt: DateTime.now(),
      );

      await _bookService.addBook(book, pickedImage.value!);
      Get.snackbar('نجاح', 'تمت إضافة الكتاب بنجاح!');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء إضافة الكتاب: $e');
    }
  }

  // إضافة تعليق
  Future<void> addComment(String bookId, CommentModel comment) async {
    try {
      await _bookService.addComment(bookId, comment);
      Get.snackbar('نجاح', 'تمت إضافة التعليق بنجاح!');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء إضافة التعليق: $e');
    }
  }

  // تحديث التقييم
  Future<void> updateRating(String bookId, double newRating) async {
    try {
      await _bookService.updateRating(bookId, newRating);
      Get.snackbar('نجاح', 'تم تحديث التقييم بنجاح!');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء تحديث التقييم: $e');
    }
  }
}

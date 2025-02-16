import 'dart:io';

import 'package:book_reviewer/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  final BookService _bookService = BookService();
  Rx<File?> pickedImage = Rx<File?>(null);
  RxBool isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  RxList<BookModel> books = <BookModel>[].obs; // قائمة الكتب العامة
  RxList<BookModel> ratingBooks = <BookModel>[].obs; // قائمة الكتب العامة
  RxList<BookModel> userBooks = <BookModel>[].obs; // قائمة كتب المستخدم
  BookModel? selectedBook;

  @override
  void onInit() {
    super.onInit();
    loadBooks(); // تحميل الكتب عند تهيئة الـ Controller
    scrollController.addListener(_onScroll);
    loadRatingBooks();
  }

  void _onScroll() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      if (isLoading.value) return; // تجنب تكرار التحميل

      isLoading.value = true;

      List<BookModel> newBooks =
          await _bookService.fetchBooks(); // انتظار جلب البيانات

      if (newBooks.isNotEmpty) {
        books.addAll(newBooks); // تحديث القائمة عند جلب بيانات جديدة
      }

      isLoading.value = false; // إيقاف اللودينغ بعد انتهاء التحميل
    }
  }

  Future<void> loadBooks() async {
    books.value = await _bookService.fetchBooks();
  }

  Future<void> loadRatingBooks() async {
    ratingBooks.value = await _bookService.fetchTopRatedBooks();
  }

  // تحميل كتب مستخدم معين
  Future<void> loadUserBooks(String userId) async {
    userBooks.value = await _bookService.fetchUserBooks(userId);
  }

  Future<void> loadBookById(String bookId) async {
    isLoading.value = true;
    selectedBook = await _bookService.fetchBookById(bookId);

    if (selectedBook != null) {
      isLoading.value = false;
      // قم بتحديث الواجهة هنا (مثل تخزين الكتاب في متغير)
      print("تم جلب الكتاب بنجاح: ${selectedBook!.title}");
    } else {
      print(bookId);
      isLoading.value = false;
      // التعامل مع الحالة عندما لا يتم العثور على الكتاب
      print("❌ لم يتم العثور على الكتاب!");
    }
  }

  // إضافة كتاب جديد
  Future<void> addBook(
      {required String title,
      required String author,
      required String description,
      required String coverImageUrl,
      required String publisherName,
      required String publisherImageUrl}) async {
    try {
      isLoading.value = true;
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
          publisherName: publisherName,
          publisherImageUrl: publisherImageUrl);

      await _bookService.addBook(book, pickedImage.value!);
      Get.snackbar('نجاح', 'تمت إضافة الكتاب بنجاح!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'حدث خطأ أثناء إضافة الكتاب: $e');
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      isLoading.value = true;

      // استخدام BookService لحذف الكتاب
      await _bookService.deleteBook(bookId);
      Get.snackbar('نجاح', 'تم حذف الكتاب بنجاح!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'حدث خطأ أثناء حذف الكتاب: $e');
    }
  }

  Future<void> editBook({
    required BookModel updatedBook,
  }) async {
    try {
      isLoading.value = true;

      // إرسال التعديل إلى BookService
      await _bookService.editBook(updatedBook, pickedImage.value!);
      Get.snackbar('نجاح', 'تم تعديل الكتاب بنجاح!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'حدث خطأ أثناء تعديل الكتاب: $e');
    }
  }

  // إضافة تعليق
}

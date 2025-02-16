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

  RxList<BookModel> books = <BookModel>[].obs;
  RxList<BookModel> laterBooks = <BookModel>[].obs;
  RxList<BookModel> ratingBooks = <BookModel>[].obs;
  RxList<BookModel> userBooks = <BookModel>[].obs;
  var selectedBook;

  @override
  void onInit() {
    super.onInit();
    loadRatingBooks();
    getLatestBooks();
    loadBooks();
    scrollController.addListener(onScroll);
  }

  void onScroll() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      if (isLoading.value) return;

      isLoading.value = true;

      List<BookModel> newBooks = await _bookService.fetchBooks();

      if (newBooks.isNotEmpty) {
        books.addAll(newBooks);
      }

      isLoading.value = false;
    }
  }

  Future<void> loadBooks() async {
    books.value = await _bookService.fetchBooks();
  }

  Future<void> loadRatingBooks() async {
    ratingBooks.value = await _bookService.fetchTopRatedBooks();
  }

  Future<void> loadUserBooks(String userId) async {
    try {
      isLoading.value = true;
      userBooks.value = await _bookService.fetchUserBooks(userId);
    } catch (e) {
      Get.snackbar('error', 'Failed to load user books: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadBookById(String bookId) async {
    isLoading.value = true;
    selectedBook = await _bookService.fetchBookById(bookId);

    if (selectedBook != null) {
      isLoading.value = false;

      print("تم جلب الكتاب بنجاح: ${selectedBook!.title}");
    } else {
      print(bookId);
      isLoading.value = false;

      print("❌ لم يتم العثور على الكتاب!");
    }
  }

  Future<void> getLatestBooks() async {
    laterBooks.value = await _bookService.fetchLatestBooks();
  }

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
          userId: '',
          rating: 5.0,
          comments: [],
          createdAt: DateTime.now(),
          publisherName: publisherName,
          publisherImageUrl: publisherImageUrl);

      await _bookService.addBook(book, pickedImage.value!);
      await loadRatingBooks();
      await getLatestBooks();
      await loadUserBooks(book.userId);
      Get.snackbar('success', 'Book added successfully!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('error', 'Failed to add book: $e');
    }
  }

  Future<void> deleteBook(String bookId, String userId) async {
    try {
      isLoading.value = true;

      await _bookService.deleteBook(bookId);
      await loadRatingBooks();
      await getLatestBooks();
      await loadUserBooks(userId);
      Get.snackbar('success', 'Book deleted successfully!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('error', 'Failed to delete book: $e');
    }
  }

  Future<void> editBook({
    required BookModel updatedBook,
  }) async {
    try {
      isLoading.value = true;

      await _bookService.editBook(
          updatedBook, pickedImage.value ?? File(updatedBook.coverImageUrl));

      await loadRatingBooks();
      await getLatestBooks();
      await loadUserBooks(updatedBook.userId);
      Get.snackbar('success', 'Book edited successfully!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('error', 'Failed to edit book: $e');
      print(e);
    }
  }
}

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
  BookModel? selectedBook;

  @override
  void onInit() {
    super.onInit();
    getRatingBooks();
    getLatestBooks();
    getBooks();
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

  Future<void> getBooks() async {
    books.value = await _bookService.fetchBooks();
  }

  Future<void> getRatingBooks() async {
    ratingBooks.value = await _bookService.fetchTopRatedBooks();
  }

  Future<void> getUserBooks(String userId) async {
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
    var book = await _bookService.fetchBookById(bookId);
    if (book == null) {
      Get.snackbar('Error', 'Book not found');
    }
    selectedBook = book;
    isLoading.value = false;
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
      await getRatingBooks();
      await getLatestBooks();
      await getUserBooks(book.userId);
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
      await getRatingBooks();
      await getLatestBooks();
      await getUserBooks(userId);
      Get.snackbar('Success', 'Book deleted successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete book: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editBook({
    required BookModel updatedBook,
  }) async {
    try {
      isLoading.value = true;

      await _bookService.editBook(
          updatedBook, pickedImage.value ?? File(updatedBook.coverImageUrl));

      await getRatingBooks();
      await getLatestBooks();
      await getUserBooks(updatedBook.userId);
      Get.snackbar('success', 'Book edited successfully!');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('error', 'Failed to edit book: $e');
    }
  }
}

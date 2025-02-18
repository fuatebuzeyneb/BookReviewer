import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../models/book_model.dart';
import 'package:uuid/uuid.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  DocumentSnapshot? lastDocument;

  Future<String?> uploadImage(File imageFile, String bookId) async {
    try {
      Reference storageReference = _storage.ref().child('book_images/$bookId');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar('error', 'Failed to upload image: $e');
      return null;
    }
  }

  Future<void> addBook(BookModel book, File imageFile) async {
    try {
      User? user = _auth.currentUser;

      var uuid = const Uuid();
      String bookId = uuid.v4();

      if (user != null) {
        String? imageUrl = await uploadImage(imageFile, bookId);

        if (imageUrl != null) {
          BookModel newBook = BookModel(
              id: bookId,
              title: book.title,
              author: book.author,
              description: book.description,
              coverImageUrl: imageUrl,
              userId: user.uid,
              rating: Random().nextDouble() * (5.0 - 2.0) + 2.0,
              comments: book.comments,
              createdAt: DateTime.now(),
              publisherName: book.publisherName,
              publisherImageUrl: book.publisherImageUrl);

          await _firestore
              .collection('books')
              .doc(bookId)
              .set(newBook.toJson());
        } else {
          Get.snackbar('error', 'Failed to upload image');
        }
      } else {
        Get.snackbar('error', 'User not authenticated');
      }
    } catch (e) {
      Get.snackbar('error', 'Failed to add book: $e');
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
    } catch (e) {
      throw Exception("error deleting book: $e");
    }
  }

  Future<void> editBook(BookModel updatedBook, File imageFile) async {
    try {
      String? imageUrl = await uploadImage(imageFile, updatedBook.id);

      BookModel newBook = BookModel(
          id: updatedBook.id,
          title: updatedBook.title,
          author: updatedBook.author,
          description: updatedBook.description,
          coverImageUrl: imageUrl ?? updatedBook.coverImageUrl,
          userId: updatedBook.userId,
          rating: updatedBook.rating,
          comments: updatedBook.comments,
          createdAt: updatedBook.createdAt,
          publisherName: updatedBook.publisherName,
          publisherImageUrl: updatedBook.publisherImageUrl);

      await _firestore
          .collection('books')
          .doc(updatedBook.id)
          .update(newBook.toJson());
    } catch (e) {
      throw Exception("error editing book: $e");
    }
  }

  Future<List<BookModel>> fetchLatestBooks({int limit = 6}) async {
    try {
      Query query = _firestore
          .collection('books')
          .orderBy('createdAt', descending: true)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("error fetching latest books: $e");
      return [];
    }
  }

  Future<List<BookModel>> fetchBooks({int limit = 8}) async {
    try {
      Query query = _firestore.collection('books').limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
      }

      return querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      Get.snackbar('error', 'Failed to fetch books: $e');
      return [];
    }
  }

  Future<List<BookModel>> fetchTopRatedBooks({int limit = 6}) async {
    try {
      Query query = _firestore
          .collection('books')
          .orderBy('rating', descending: true)
          .limit(limit);

      QuerySnapshot querySnapshot = await query.get();

      List<BookModel> books = querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return books;
    } catch (e) {
      Get.snackbar('error', 'Failed to fetch books: $e');
      return [];
    }
  }

  Future<List<BookModel>> fetchUserBooks(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('books')
          .where('userId', isEqualTo: userId)
          .get();

      List<BookModel> books = querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return books;
    } catch (e) {
      Get.snackbar('error', 'Failed to fetch books: $e');
      return [];
    }
  }

  Future<BookModel?> fetchBookById(String bookId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('books').doc(bookId).get();

      if (docSnapshot.exists) {
        return BookModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        Get.snackbar('error', 'Book not found');
        return null;
      }
    } catch (e) {
      Get.snackbar('error', 'Failed to fetch book: $e');
      return null;
    }
  }
}

import 'dart:io';
import 'dart:math';

import 'package:book_reviewer/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> addBook(BookModel book, File imageFile) async {
    try {
      // احصل على معرف المستخدم الحالي
      User? user = _auth.currentUser;

      var uuid = const Uuid();
      String bookId = uuid.v4(); // توليد معرّف فريد للكتاب

      if (user != null) {
        // رفع الصورة إلى Firebase Storage
        String? imageUrl = await uploadImage(imageFile, bookId);

        if (imageUrl != null) {
          // نسخ الموديل مع إضافة timestamp واستخدام الرابط المرفوع للصورة
          BookModel newBook = BookModel(
              id: bookId,
              title: book.title,
              author: book.author,
              description: book.description,
              coverImageUrl: imageUrl, // حفظ الرابط هنا
              userId: user.uid,
              rating:
                  Random().nextDouble() * (5.0 - 2.0) + 2.0, // إضافة التقييم
              comments: book.comments, // إضافة التعليقات (إن وجدت)
              createdAt: DateTime.now(),
              publisherName: book.publisherName,
              publisherImageUrl: book.publisherImageUrl);

          // إضافة بيانات الكتاب إلى مجموعة "books" في Firestore
          await _firestore
              .collection('books')
              .doc(bookId)
              .set(newBook.toJson());

          print("تمت إضافة الكتاب بنجاح");
        } else {
          print("لم يتم رفع الصورة، الكتاب لن يُضاف.");
        }
      } else {
        print("يجب على المستخدم تسجيل الدخول لإضافة كتاب.");
      }
    } catch (e) {
      print("حدث خطأ أثناء إضافة الكتاب: $e");
    }
  }

  Future<List<BookModel>> fetchBooks({int limit = 8}) async {
    try {
      Query query = _firestore
          .collection('books')
          .orderBy('createdAt', descending: true) // 🔹 فرز من الأحدث إلى الأقدم
          .limit(limit);

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
      print("❌ حدث خطأ أثناء جلب الكتب: $e");
      return [];
    }
  }

  Future<List<BookModel>> fetchTopRatedBooks({int limit = 6}) async {
    try {
      Query query = _firestore
          .collection('books')
          .orderBy('rating',
              descending: true) // 🔹 ترتيب الكتب من الأعلى تقييمًا إلى الأقل
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
      }

      List<BookModel> books = querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return books;
    } catch (e) {
      print("❌ حدث خطأ أثناء جلب الكتب: $e");
      return [];
    }
  }

  // جلب كتب مستخدم معين
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
      print("❌ حدث خطأ أثناء جلب كتب المستخدم: $e");
      return [];
    }
  }

  Future<BookModel?> fetchBookById(String bookId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('books').doc(bookId).get();

      if (docSnapshot.exists) {
        // إرجاع الكتاب باستخدام الـ ID
        return BookModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print("❌ الكتاب غير موجود!");
        return null;
      }
    } catch (e) {
      print("❌ حدث خطأ أثناء جلب الكتاب: $e");
      return null;
    }
  }

  // إضافة تعليق إلى الكتاب
  Future<void> addComment(String bookId, CommentModel comment) async {
    try {
      DocumentReference bookRef = _firestore.collection('books').doc(bookId);

      // إضافة التعليق إلى قائمة التعليقات في Firestore
      await bookRef.update({
        'comments': FieldValue.arrayUnion([comment.toJson()])
      });

      print("تمت إضافة التعليق بنجاح");
    } catch (e) {
      print("حدث خطأ أثناء إضافة التعليق: $e");
    }
  }

  // تحديث التقييم
  Future<void> updateRating(String bookId, double newRating) async {
    try {
      DocumentReference bookRef = _firestore.collection('books').doc(bookId);

      // تحديث التقييم في Firestore
      await bookRef.update({'rating': newRating});

      print("تم تحديث التقييم بنجاح");
    } catch (e) {
      print("حدث خطأ أثناء تحديث التقييم: $e");
    }
  }
}

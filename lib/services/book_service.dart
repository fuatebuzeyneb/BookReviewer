import 'dart:io';

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
            rating: book.rating, // إضافة التقييم
            comments: book.comments, // إضافة التعليقات (إن وجدت)
            createdAt: DateTime.now(),
          );

          // إضافة بيانات الكتاب إلى مجموعة "books" في Firestore
          await _firestore.collection('books').add(newBook.toJson());
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

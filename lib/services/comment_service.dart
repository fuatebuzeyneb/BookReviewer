import 'package:book_reviewer/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  // إضافة تعليق
  static Future<void> addCommentToFirebase(
      String bookId, CommentModel comment) async {
    try {
      final commentData = comment.toJson();

      // إضافة التعليق إلى مجموعة "comments" داخل مستند الكتاب في Firebase
      await FirebaseFirestore.instance
          .collection('books') // تأكد من أن هذا هو المسار الصحيح
          .doc(bookId) // الكتاب الذي نريد إضافة التعليق إليه
          .update({
        'comments':
            FieldValue.arrayUnion([commentData]), // إضافة التعليق إلى القائمة
      });
    } catch (e) {
      print("Error adding comment to Firebase: $e");
      rethrow; // إعادة الخطأ إذا فشل
    }
  }

  static Future<CommentModel?> getUserComment(
      String bookId, String userId) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return CommentModel.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      print("Error fetching user comment: $e");
      return null;
    }
  }

  // تحديث تعليق
  static Future<void> updateCommentInFirebase(
      String bookId, String commentId, CommentModel updatedComment) async {
    try {
      final commentData = updatedComment.toJson();
      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .doc(commentId)
          .update(commentData);
    } catch (e) {
      print("Error updating comment in Firebase: $e");
    }
  }

  // حذف تعليق
  static Future<void> deleteCommentFromFirebase(
      String bookId, String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .doc(commentId)
          .delete();
    } catch (e) {
      print("Error deleting comment from Firebase: $e");
    }
  }

  // جلب التعليقات
  static Future<List<CommentModel>> fetchCommentsFromFirebase(
      String bookId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .get();

      return querySnapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching comments from Firebase: $e");
      return [];
    }
  }
}

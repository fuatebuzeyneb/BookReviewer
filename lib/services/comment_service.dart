import 'package:book_reviewer/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  // إضافة تعليق
  static Future<void> addCommentToFirebase(
      String bookId, CommentModel comment) async {
    try {
      final commentData = comment.toJson();
      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .add(commentData);
    } catch (e) {
      print("Error adding comment to Firebase: $e");
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

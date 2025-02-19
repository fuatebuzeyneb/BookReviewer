import 'package:book_reviewer/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  static Future<void> addCommentToFirebase(
      String bookId, CommentModel comment) async {
    try {
      final commentData = comment.toJson();

      await FirebaseFirestore.instance.collection('books').doc(bookId).update({
        'comments': FieldValue.arrayUnion([commentData]),
      });
    } catch (e) {
      print("Error adding comment to Firebase: $e");
      rethrow;
    }
  }

  static Future<void> editCommentInFirebase(
      String bookId, int index, CommentModel updatedComment) async {
    try {
      final bookRef =
          FirebaseFirestore.instance.collection('books').doc(bookId);

      final bookSnapshot = await bookRef.get();
      if (!bookSnapshot.exists) {
        print("Book not found");
        return;
      }

      List<dynamic> comments = bookSnapshot.data()?['comments'] ?? [];

      if (index < 0 || index >= comments.length) {
        print("Invalid index: $index");
        return;
      }

      comments[index] = updatedComment.toJson();

      await bookRef.update({'comments': comments});

      print("Comment updated successfully at index: $index");
    } catch (e) {
      print("Error updating comment in Firebase: $e");
    }
  }

  static Future<void> deleteCommentFromFirebase(
      String bookId, int index) async {
    try {
      final bookRef =
          FirebaseFirestore.instance.collection('books').doc(bookId);

      final bookSnapshot = await bookRef.get();
      if (!bookSnapshot.exists) {
        print("Book not found");
        return;
      }

      List<dynamic> comments = bookSnapshot.data()?['comments'] ?? [];

      if (index < 0 || index >= comments.length) {
        print("Invalid index: $index");
        return;
      }

      comments.removeAt(index);

      await bookRef.update({'comments': comments});

      print("Comment deleted successfully at index: $index");
    } catch (e) {
      print("Error deleting comment from Firebase: $e");
    }
  }
}

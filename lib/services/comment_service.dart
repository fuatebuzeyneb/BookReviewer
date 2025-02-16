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

  static Future<CommentModel?> getUserComment(
      String bookId, String userId) async {
    try {
      final bookSnapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get();

      if (!bookSnapshot.exists ||
          !bookSnapshot.data()!.containsKey('comments')) {
        print("No comments found for book $bookId");
        return null;
      }

      final commentsData = bookSnapshot.data()!['comments'] as List<dynamic>;

      final userComment = commentsData
          .where((commentData) =>
              CommentModel.fromJson(commentData).userId == userId)
          .map((commentData) => CommentModel.fromJson(commentData))
          .firstWhere(
            (comment) => comment.userId == userId,
          );

      return userComment;
    } catch (e) {
      print("Error fetching user comment: $e");
      return null;
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

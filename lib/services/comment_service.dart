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
      final bookSnapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get(); // الحصول على المستند مباشرة

      // التأكد من وجود حقل "comments" في المستند
      if (!bookSnapshot.exists ||
          !bookSnapshot.data()!.containsKey('comments')) {
        print("No comments found for book $bookId");
        return null; // إذا لم يكن هناك تعليقات، نرجع null
      }

      // استخراج التعليقات من الحقل "comments"
      final commentsData = bookSnapshot.data()!['comments'] as List<dynamic>;

      // تصفية التعليقات حسب userId
      final userComment = commentsData
          .where((commentData) =>
              CommentModel.fromJson(commentData).userId == userId)
          .map((commentData) => CommentModel.fromJson(commentData))
          .firstWhere(
            (comment) => comment.userId == userId,
          ); // إرجاع أول تعليق يتطابق مع userId أو null

      return userComment; // هنا سيتم إرجاع نوع CommentModel؟
    } catch (e) {
      print("Error fetching user comment: $e");
      return null; // في حالة حدوث خطأ نرجع null
    }
  }

  // تحديث تعليق
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

      // تحديث التعليق في القائمة بناءً على `index`
      comments[index] = updatedComment.toJson(); // تحديث التعليق الجديد

      // تحديث Firestore فقط إذا تم تعديل تعليق
      await bookRef.update({'comments': comments});

      print("Comment updated successfully at index: $index");
    } catch (e) {
      print("Error updating comment in Firebase: $e");
    }
  }

  // حذف تعليق
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

      // حذف التعليق بناءً على `index`
      comments.removeAt(index);

      // تحديث Firestore فقط إذا تم حذف تعليق
      await bookRef.update({'comments': comments});

      print("Comment deleted successfully at index: $index");
    } catch (e) {
      print("Error deleting comment from Firebase: $e");
    }
  }

  // جلب التعليقات
}

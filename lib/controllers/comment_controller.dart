import 'package:book_reviewer/models/comment_model.dart';
import 'package:book_reviewer/services/comment_service.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  RxList<CommentModel> comments = <CommentModel>[].obs;

  Rxn<CommentModel> userComment = Rxn<CommentModel>();

  // إضافة تعليق
  void addComment(
      {required String bookId, required CommentModel comment}) async {
    try {
      await CommentService.addCommentToFirebase(
          bookId, comment); // إضافة التعليق إلى Firebase
      comments
          .add(comment); // إضافة التعليق إلى القائمة محلياً في الـ Controller
      update(); // تحديث الـ UI إذا كنت تستخدم GetX
      Get.snackbar('نجاح', 'تمت إضافة التعليق بنجاح!');
    } catch (e) {
      print("Error adding comment: $e");
      Get.snackbar('خطأ', 'فشل إضافة التعليق: $e');
    }
  }

  Future<void> fetchUserComment(
      {required String bookId, required String userId}) async {
    try {
      CommentModel? comment =
          await CommentService.getUserComment(bookId, userId);
      userComment.value = comment; // تحديث الحالة
    } catch (e) {
      print("Error fetching user comment: $e");
    }
  }

  // تعديل تعليق
  void updateComment(
      String bookId, String commentId, CommentModel updatedComment) async {
    try {
      await CommentService.updateCommentInFirebase(
          bookId, commentId, updatedComment);
      // تحديث التعليق محلياً
      int index = comments.indexWhere((comment) => comment.userId == commentId);
      if (index != -1) {
        comments[index] = updatedComment;
      }
    } catch (e) {
      print("Error updating comment: $e");
    }
  }

  // حذف تعليق
  void deleteComment(String bookId, String commentId) async {
    try {
      await CommentService.deleteCommentFromFirebase(bookId, commentId);
      // إزالة التعليق محلياً
      comments.removeWhere((comment) => comment.userId == commentId);
    } catch (e) {
      print("Error deleting comment: $e");
    }
  }

  // جلب التعليقات من Firebase
  void fetchComments(String bookId) async {
    try {
      final fetchedComments =
          await CommentService.fetchCommentsFromFirebase(bookId);
      comments.value = fetchedComments; // تحديث التعليقات
    } catch (e) {
      print("Error fetching comments: $e");
    }
  }
}

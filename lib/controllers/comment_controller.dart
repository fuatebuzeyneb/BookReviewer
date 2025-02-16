import 'package:book_reviewer/models/comment_model.dart';
import 'package:book_reviewer/services/comment_service.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  RxList<CommentModel> comments = <CommentModel>[].obs;
  RxBool isLoading = false.obs;
  Rxn<CommentModel> userComment = Rxn<CommentModel>();

  // إضافة تعليق
  void addComment(
      {required String bookId,
      required CommentModel comment,
      required String userId}) async {
    try {
      await CommentService.addCommentToFirebase(
          bookId, comment); // إضافة التعليق إلى Firebase
      comments.add(comment);
      update(); // إضافة التعليق إلى القائمة محلياً في الـ Controller

      // تحديث الـ UI إذا كنت تستخدم GetX
      Get.back();

      Get.snackbar('نجاح', 'تمت إضافة التعليق بنجاح!');
    } catch (e) {
      print("Error adding comment: $e");
      Get.snackbar('خطأ', 'فشل إضافة التعليق: $e');
    }
  }

  // Future<void> fetchUserComment(
  //     {required String bookId, required String userId}) async {
  //   try {
  //     isLoading.value = true;
  //     CommentModel? comment =
  //         await CommentService.getUserComment(bookId, userId);
  //     userComment.value = comment; // تحديث الحالة

  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     print("Error fetching user comment: $e");
  //   }
  // }

  // تعديل تعليق
  Future<void> editComment(
      {required String bookId,
      required int index,
      required CommentModel updatedComment}) async {
    try {
      isLoading.value = true;
      // استدعاء الـ Service لتحديث التعليق في Firebase
      await CommentService.editCommentInFirebase(bookId, index, updatedComment);

      // تحديث التعليق محليًا بناءً على `index`
      if (index >= 0 && index < comments.length) {
        // تحديث النص والتقييم محليًا
        comments[index] = updatedComment;
      } else {
        isLoading.value = false;
        print("Index out of range: $index");
      }

      isLoading.value = false;
      update();

      Get.back();
      print("Comment updated successfully at index: $index");
    } catch (e) {
      isLoading.value = false;
      print("Error updating comment: $e");
    }
  }

  // حذف تعليق
  Future<void> deleteComment(
      {required String bookId, required int index}) async {
    try {
      isLoading.value = true;
      await CommentService.deleteCommentFromFirebase(bookId, index);

      // إزالة التعليق محلياً بناءً على index
      if (index >= 0 && index < comments.length) {
        comments.removeAt(index);
      } else {
        isLoading.value = false;
        print("Index out of range: $index");
      }
      isLoading.value = false;
      update();
      print("Comment deleted successfully at index: $index");
    } catch (e) {
      isLoading.value = false;
      print("Error deleting comment: $e");
    }
  }

  // // جلب التعليقات من Firebase
  // Future<void> fetchComments(String bookId) async {
  //   try {
  //     isLoading.value = true;
  //     final fetchedComments =
  //         await CommentService.fetchCommentsFromFirebase(bookId);
  //     comments.value = fetchedComments; // تحديث التعليقات
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     print("Error fetching comments: $e");
  //   }
  // }
}

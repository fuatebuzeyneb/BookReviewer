import 'package:book_reviewer/controllers/book_controller.dart';
import 'package:book_reviewer/models/comment_model.dart';
import 'package:book_reviewer/services/comment_service.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  RxList<CommentModel> comments = <CommentModel>[].obs;
  RxBool isLoading = false.obs;
  Rxn<CommentModel> userComment = Rxn<CommentModel>();

  void addComment(
      {required String bookId,
      required CommentModel comment,
      required String userId}) async {
    try {
      await CommentService.addCommentToFirebase(bookId, comment);
      comments.add(comment);
      update();

      Get.back();

      Get.snackbar('success', 'Comment added successfully!');
    } catch (e) {
      print("Error adding comment: $e");
      Get.snackbar('error', 'Failed to add comment: $e');
    }
  }

  Future<void> editComment(
      {required String bookId,
      required int index,
      required CommentModel updatedComment}) async {
    try {
      isLoading.value = true;

      await CommentService.editCommentInFirebase(bookId, index, updatedComment);

      if (index >= 0 && index < comments.length) {
        comments[index] = updatedComment;

        final bookController = Get.find<BookController>();

        await bookController.loadBookById(bookId);
      } else {
        isLoading.value = false;
        print("Index out of range: $index");
      }

      isLoading.value = false;

      Get.back();

      Get.snackbar('success', 'Comment edited successfully!');
    } catch (e) {
      print("Error adding comment: $e");
      Get.snackbar('error', 'Failed to add comment: $e');
    }
  }

  Future<void> deleteComment(
      {required String bookId, required int index}) async {
    try {
      isLoading.value = true;
      await CommentService.deleteCommentFromFirebase(bookId, index);

      if (index >= 0 && index < comments.length) {
        comments.removeAt(index);
        final bookController = Get.find<BookController>();

        await bookController.loadBookById(bookId);
      } else {
        isLoading.value = false;
        print("Index out of range: $index");
      }
      isLoading.value = false;
      update();

      Get.snackbar('success', 'Comment deleted successfully!');
    } catch (e) {
      print("Error adding comment: $e");
      Get.snackbar('error', 'Failed to add comment: $e');
    }
  }
}

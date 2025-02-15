import 'package:book_reviewer/models/comment_model.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImageUrl;
  final String userId;
  final double rating;
  final List<CommentModel> comments; // قائمة التعليقات
  final DateTime createdAt;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImageUrl,
    required this.userId,
    required this.rating, // التقييم الافتراضي 0
    required this.comments, // قائمة التعليقات الافتراضية فارغة
    required this.createdAt,
  });

  // تحويل بيانات الكتاب إلى صيغة JSON لتخزينها في Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'userId': userId,
      'rating': rating,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'createdAt': createdAt,
    };
  }

  // إنشاء موديل من بيانات Firestore
  factory BookModel.fromJson(Map<String, dynamic> json, String documentId) {
    return BookModel(
      id: documentId,
      title: json['title'],
      author: json['author'],
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      userId: json['userId'],
      rating: json['rating'] ?? 0.0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((commentJson) => CommentModel.fromJson(commentJson))
              .toList() ??
          [],
      createdAt: json['createdAt'].toDate(),
    );
  }
}

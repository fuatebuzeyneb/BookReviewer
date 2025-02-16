import 'package:book_reviewer/models/comment_model.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImageUrl;
  final String publisherImageUrl;
  final String userId;
  final double rating;
  final List<CommentModel> comments;
  final DateTime createdAt;
  final String publisherName;

  BookModel(
      {required this.id,
      required this.title,
      required this.author,
      required this.description,
      required this.coverImageUrl,
      required this.userId,
      required this.rating,
      required this.comments,
      required this.createdAt,
      required this.publisherName,
      required this.publisherImageUrl});

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
      'publisherName': publisherName,
      'publisherImageUrl': publisherImageUrl
    };
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
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
      publisherName: json['publisherName'],
      publisherImageUrl: json['publisherImageUrl'],
    );
  }
}

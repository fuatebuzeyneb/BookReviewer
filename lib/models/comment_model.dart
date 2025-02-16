class CommentModel {
  final String userId;
  final String userName;
  final String userImageUrl;
  final String commentText;
  final DateTime createdAt;
  double ratingValue;

  CommentModel({
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.commentText,
    required this.createdAt,
    required this.ratingValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
      'commentText': commentText,
      'createdAt': createdAt,
      'ratingValue': ratingValue,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'],
      userName: json['userName'],
      userImageUrl: json['userImageUrl'],
      commentText: json['commentText'],
      createdAt: json['createdAt'].toDate(),
      ratingValue: json['ratingValue'],
    );
  }
}

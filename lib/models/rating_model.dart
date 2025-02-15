class Rating {
  final String userId;
  final double ratingValue;

  Rating({
    required this.userId,
    required this.ratingValue,
  });

  // تحويل بيانات التقييم إلى صيغة JSON لتخزينها في Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'ratingValue': ratingValue,
    };
  }

  // إنشاء موديل من بيانات Firestore
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json['userId'],
      ratingValue: json['ratingValue'] ?? 0.0,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String? fullName;
  String? profilePicture;
  String createdAt;

  UserModel({
    required this.uid,
    required this.email,
    this.fullName,
    this.profilePicture,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      fullName: json['fullName'],
      profilePicture: json['profilePicture'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'profilePicture': profilePicture,
      'createdAt': createdAt,
    };
  }
}

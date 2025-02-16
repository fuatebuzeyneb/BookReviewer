import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final box = GetStorage();

  Future<String?> uploadImage(File imageFile, String userId) async {
    try {
      Reference storageReference = _storage.ref().child('user_images/$userId');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<User?> signUp(
      UserModel userModel, String password, File? imageFile) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String? profilePicture;

        if (imageFile != null) {
          profilePicture = await uploadImage(imageFile, user.uid);
        }

        UserModel newUser = UserModel(
          uid: user.uid,
          fullName: userModel.fullName,
          email: userModel.email,
          profilePicture: profilePicture,
          createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        );

        await saveUserToFirestore(newUser);
        await getUserDataFromFirebase(userCredential.user!.uid);
      }
      return user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toJson());

      print("User saved to Firestore");
    } catch (e) {
      print("Error saving user to Firestore: $e");
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await getUserDataFromFirebase(userCredential.user!.uid);

      return userCredential.user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> getIdToken() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return null;
  }

  Future<UserModel?> getUserData(String uid) async {
    final localData = box.read('userData');
    if (localData != null) {
      return UserModel.fromJson(localData);
    }
    return null;
  }

  Future<void> saveUserData(UserModel user) async {
    await box.write('userData', user.toJson());
  }

  void clearUserData() {
    box.remove('userData');
  }

  Future<void> getUserDataFromFirebase(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        UserModel userModel =
            UserModel.fromJson(doc.data() as Map<String, dynamic>);
        saveUserData(userModel);
      }
    } catch (e) {}
  }
}

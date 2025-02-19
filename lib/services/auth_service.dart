import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final box = GetStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error signing up", _getFirebaseErrorMessage(e.code));
      return null;
    } catch (e) {
      Get.snackbar("Unexpected registration error",
          "An error occurred during registration. Try to reset.");
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
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error signing in", _getFirebaseErrorMessage(e.code));
      return null;
    } catch (e) {
      Get.snackbar("Unexpected login error",
          "An error occurred during login. Try to reset.");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Future<String?> getIdToken() async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     return await user.getIdToken();
  //   }
  //   return null;
  // }

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
    } catch (e) {
      print("Error getting user data from Firestore: $e");
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        var userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          UserModel newUser = UserModel(
            uid: user.uid,
            fullName: user.displayName ?? '',
            email: user.email ?? '',
            profilePicture: user.photoURL ?? '',
            createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          );
          await saveUserToFirestore(newUser);
        }

        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
          message: 'Error signing in with Google: $e', code: e.code);
    } catch (e) {
      throw Exception("Failed to sign in with Google: $e");
    }
    return null;
  }

  String _getFirebaseErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger one.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

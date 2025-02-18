import 'dart:io';

import 'package:book_reviewer/models/user_model.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final AuthService _authService = AuthService();

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;
  Rx<File?> pickedImage = Rx<File?>(null);
  final box = GetStorage();
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> loadUserData() async {
    final userData = box.read('userData');
    if (userData != null) {
      userModel.value = UserModel.fromJson(userData);
      print("Loaded user data: $userData");
    } else {
      print("No user data found in local storage");
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String imageFile}) async {
    try {
      isLoading.value = true;

      UserModel userModel = UserModel(
        uid: '',
        email: email,
        fullName: fullName,
        profilePicture: imageFile,
        createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      );

      User? user =
          await _authService.signUp(userModel, password, pickedImage.value);
      if (user != null) {
        print("User signed up successfully with image: ${user.uid}");

        loadUserData();
        Get.offNamed(Routes.bottomNav);
      } else {
        print("Error signing up user");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      User? user = await _authService.signIn(email, password);
      if (user != null) {
        loadUserData();
        Get.offNamed(Routes.bottomNav);
      } else {
        print("Error signing in user");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveUserData(UserModel user) async {
    await box.write('userData', user.toJson());
    print("User data saved locally: ${user.toJson()}");
  }

  Future<void> signOut() async {
    await _authService.signOut();
    box.remove('userData');

    await googleSignIn.signOut();

    Get.offAllNamed(Routes.signin);
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      UserCredential? userCredential = await _authService.signInWithGoogle();

      if (userCredential != null) {
        loadUserData();
        Get.offNamed(Routes.bottomNav);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to sign in with Google: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

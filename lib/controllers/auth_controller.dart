import 'dart:io';

import 'package:book_reviewer/models/user_model.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;
  Rx<File?> pickedImage = Rx<File?>(null);
  final box = GetStorage(); // التخزين المحلي

  Future<void> loadUserData() async {
    final userData = box.read('userData');
    if (userData != null) {
      userModel.value = UserModel.fromJson(userData);
      print("Loaded user data: $userData");
      // هنا يمكنك توجيه المستخدم مباشرة بعد تحميل البيانات
      //Get.offNamed(Routes.bottomNav); // الانتقال إلى الصفحة الرئيسية
    } else {
      print("No user data found in local storage");
      //  Get.offNamed(Routes.signin); // الانتقال إلى صفحة تسجيل الدخول
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

      User? user = await _authService.signUp(
          userModel, password, pickedImage.value); // رفع الصورة وتسجيل المستخدم
      if (user != null) {
        print("User signed up successfully with image: ${user.uid}");

        saveUserData(userModel);
        loadUserData();
        Get.offNamed(Routes.bottomNav);
      } else {
        print("Error signing up user");
      }
    } finally {
      isLoading.value = false; // إنهاء التحميل
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      User? user = await _authService.signIn(email, password);
      if (user != null) {
        await getUserDataFromFirebase(
            user.uid); // تحميل بيانات المستخدم من Firebase
        loadUserData(); // تحميل البيانات من التخزين المحلي بعد التحديث
        Get.offNamed(Routes.bottomNav);
      } else {
        print("Error signing in user");
      }
    } finally {
      isLoading.value = false;
    }
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

  Future<void> saveUserData(UserModel user) async {
    await box.write('userData', user.toJson());
    print(
        "User data saved locally: ${user.toJson()}"); // للتأكد من تخزين البيانات
  }

  Future<void> signOut() async {
    await _authService.signOut(); // تسجيل الخروج من Firebase
    box.remove('userData'); // حذف بيانات المستخدم من التخزين المحلي

    Get.offAllNamed(Routes.signin); // الانتقال إلى شاشة تسجيل الدخول
  }
}

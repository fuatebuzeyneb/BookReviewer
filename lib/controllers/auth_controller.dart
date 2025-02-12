import 'package:book_reviewer/models/user_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final AuthService _authService = AuthService();

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null); // بيانات المستخدم

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());

    firebaseUser.listen((User? user) async {
      if (user != null) {
        userModel.value = await _authService.getUserData(user.uid);
      } else {
        userModel.value = null;
      }
    });
  }

  Future<void> printUserToken() async {
    String? token = await _authService.getIdToken();
    if (token != null) {
      print("User Token: $token");
    } else {
      print("No token found.");
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    User? user = await _authService.signUp(email, password, fullName);
    if (user != null) {
      // Get.snackbar("Success", "Account created successfully!");
    } else {
      // Get.snackbar("Error", "Failed to sign up");
    }
  }

  Future<void> signIn(String email, String password) async {
    User? user = await _authService.signIn(email, password);
    if (user != null) {
      // Get.snackbar("Success", "Logged in successfully!");
      printUserToken(); // جلب التوكن بعد تسجيل الدخول
    } else {
      //    Get.snackbar("Error", "Failed to sign in");
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.snackbar("Success", "Logged out successfully!");
  }
}

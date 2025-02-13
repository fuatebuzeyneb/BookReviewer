import 'package:book_reviewer/models/user_model.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final AuthService _authService = AuthService();

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxBool isLoading = false.obs; // حالة التحميل

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseUser, (User? user) async {
      userModel.value =
          user != null ? await _authService.getUserData(user.uid) : null;
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
    try {
      isLoading.value = true; // بدء التحميل
      User? user = await _authService.signUp(email, password, fullName);
      if (user != null) {
      } else {}
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      User? user = await _authService.signIn(email, password);
      if (user != null) {
        printUserToken();

        Get.offNamed(Routes.homeView);
      } else {}
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();

    Get.offAllNamed("/login");
  }
}

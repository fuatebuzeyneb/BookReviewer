import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_reviewer/routes/routes.dart'; // تأكد من المسار الصحيح

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تأخير لمدة 3 ثواني قبل الانتقال إلى الشاشة التالية
    Future.delayed(const Duration(seconds: 3), () {
      // هنا يجب أن تقوم بالتحقق من البيانات المخزنة أو الانتقال مباشرة
      // إذا كانت البيانات موجودة يمكن توجيه المستخدم إلى الصفحة الرئيسية
      Get.put(AuthController()).loadUserData();
      Get.offNamed(Get.put(AuthController()).userModel.value == null
          ? Routes.signin
          : Routes.bottomNav);
    });

    return const Scaffold(
      backgroundColor: Colors.blue, // اختر أي لون تريد
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book, // أي أيقونة تريدها
              size: 100.0,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Book Reviewer',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

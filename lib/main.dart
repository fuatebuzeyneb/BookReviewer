import 'package:book_reviewer/controllers/auth_controller.dart';
import 'package:book_reviewer/views/screens/main_screens/home_view.dart';
import 'package:book_reviewer/routes/app_pages.dart';
import 'package:book_reviewer/routes/routes.dart';
import 'package:book_reviewer/views/screens/auth_screens/sign_in_view.dart';
import 'package:book_reviewer/views/screens/auth_screens/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.signin,
      getPages: AppPages.pages,
    );
  }
}

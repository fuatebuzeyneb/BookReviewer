import 'package:book_reviewer/home_view.dart';
import 'package:book_reviewer/views/screens/sign_in_view.dart';
import 'package:book_reviewer/views/screens/sign_up_view.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.signin, page: () => SigninView()),
    GetPage(name: Routes.signup, page: () => SignupView()),
    // GetPage(name: Routes.profile, page: () => ProfileView()),
    // GetPage(name: Routes.settings, page: () => SettingsView()),
  ];
}

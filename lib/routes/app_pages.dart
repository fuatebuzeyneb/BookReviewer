import 'package:book_reviewer/views/screens/main_screens/add_book_view.dart';
import 'package:book_reviewer/views/screens/main_screens/home_view.dart';
import 'package:book_reviewer/views/screens/auth_screens/sign_in_view.dart';
import 'package:book_reviewer/views/screens/auth_screens/sign_up_view.dart';
import 'package:book_reviewer/views/screens/main_screens/pfofile_view.dart';
import 'package:book_reviewer/views/screens/other_screens/book_details_view.dart';
import 'package:book_reviewer/views/screens/other_screens/my_books_view.dart';
import 'package:book_reviewer/views/screens/other_screens/splash_view.dart';
import 'package:book_reviewer/views/widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.signin, page: () => SigninView()),
    GetPage(name: Routes.signup, page: () => SignupView()),
    GetPage(name: Routes.homeView, page: () => HomeView()),
    GetPage(name: Routes.profileView, page: () => ProfileView()),
    GetPage(name: Routes.addBookView, page: () => AddBookView()),
    GetPage(name: Routes.bottomNav, page: () => const BottomNavBar()),
    GetPage(name: Routes.bookDetailsView, page: () => const BookDetailsView()),
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.myBooksView, page: () => MyBooksView()),
  ];
}

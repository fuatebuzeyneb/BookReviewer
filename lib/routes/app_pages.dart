import 'package:book_reviewer/views/home/add_book_view.dart';
import 'package:book_reviewer/views/home/home_view.dart';
import 'package:book_reviewer/views/auth/sign_in_view.dart';
import 'package:book_reviewer/views/auth/sign_up_view.dart';
import 'package:book_reviewer/views/home/profile_view.dart';
import 'package:book_reviewer/views/books/book_details_view.dart';
import 'package:book_reviewer/views/books/my_books_view.dart';
import 'package:book_reviewer/views/auth/splash_view.dart';
import 'package:book_reviewer/views/books/all_books_view.dart';
import 'package:book_reviewer/views/widgets/navigation/bottom_nav_bar.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.signin, page: () => SigninView()),
    GetPage(name: Routes.signup, page: () => SignupView()),
    GetPage(name: Routes.homeView, page: () => HomeView()),
    GetPage(name: Routes.profileView, page: () => ProfileView()),
    GetPage(
        name: Routes.addBookView,
        page: () => AddBookView(
              itIsEdit: true,
            )),
    GetPage(name: Routes.bottomNav, page: () => const BottomNavBar()),
    GetPage(name: Routes.bookDetailsView, page: () => BookDetailsView()),
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.myBooksView, page: () => MyBooksView()),
    GetPage(name: Routes.allBooksView, page: () => AllBooksView()),
  ];
}

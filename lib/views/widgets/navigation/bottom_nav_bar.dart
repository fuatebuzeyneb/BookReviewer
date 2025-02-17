import 'package:book_reviewer/views/home/add_book_view.dart';
import 'package:book_reviewer/views/home/home_view.dart';
import 'package:book_reviewer/views/home/profile_view.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static String id = 'BottomNavBar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int? initialIndex =
        ModalRoute.of(context)?.settings.arguments as int?;
    if (initialIndex != null) {
      setState(() {
        currentIndex = initialIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> navPages = [
      HomeView(),
      AddBookView(),
      ProfileView(),
    ];

    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home, size: 22),
      ),
      const BottomNavigationBarItem(
        label: 'Add Book',
        icon: Icon(Icons.add_circle, size: 22),
      ),
      const BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(
          Icons.person,
          size: 22,
        ),
      ),
    ];

    return Scaffold(
      body: navPages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedFontSize: 12,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Tajawal'),
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
        ),
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
        items: navItems,
      ),
    );
  }
}

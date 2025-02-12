

// import 'package:flutter/material.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//   static String id = 'BottomNavBar';

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int currentIndex = 0;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final int? initialIndex =
//         ModalRoute.of(context)?.settings.arguments as int?;
//     if (initialIndex != null) {
//       setState(() {
//         currentIndex = initialIndex;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> navPages = [
//       const HomePage(),
//       const FavoritePage(),
//       const AddAdPage(),
//       const ProfilePage(),
//     ];

//     final List<BottomNavigationBarItem> navItems = [
//       BottomNavigationBarItem(
//         label: S.of(context).Home,
//         icon: const Icon(Icons.home, size: 28),
//       ),
//       BottomNavigationBarItem(
//         label: S.of(context).Favorites,
//         icon: const Icon(Icons.favorite_border, size: 28),
//       ),
//       BottomNavigationBarItem(
//         label: S.of(context).PlaceAnAd,
//         icon: Icon(
//           Icons.add_circle,
//           color: AppColors.primary,
//           size: 28,
//         ),
//       ),
//       BottomNavigationBarItem(
//         label: S.of(context).Menu,
//         icon: const Icon(Icons.reorder, size: 28),
//       ),
//     ];

//     return Scaffold(
//       body: navPages[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         unselectedFontSize: 14,
//         unselectedLabelStyle: const TextStyle(fontFamily: 'Tajawal'),
//         selectedLabelStyle: const TextStyle(
//           color: Colors.black,
//           fontFamily: 'Tajawal',
//           fontWeight: FontWeight.bold,
//         ),
//         selectedFontSize: 14,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.black87,
//         unselectedItemColor: Colors.grey,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         elevation: 0,
//         onTap: (index) => _onItemTapped(index, context),
//         currentIndex: currentIndex,
//         items: navItems,
//       ),
//     );
//   }

//   void _onItemTapped(int index, BuildContext context) {
//     if ((index == 1 || index == 2) && !context.read<AuthCubit>().isSignedIn()) {
//       ///////////   !   قبل الكةنتكست
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         enableDrag: false,
//         builder: (context) => const LoginOptionsBottomSheet(),
//       );
//       return;
//     } else if (index == 2 && context.read<AuthCubit>().isSignedIn()) {
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         enableDrag: false,
//         builder: (context) => const AddAdBottomSheet(),
//       ).whenComplete(() {
//         setState(() {
//           currentIndex = 0;
//         });
//       });
//     }

//     setState(() {
//       currentIndex = index;
//     });
//   }
// }

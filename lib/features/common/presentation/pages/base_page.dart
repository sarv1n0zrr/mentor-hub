import 'package:flutter/material.dart';
import 'package:mentor_hub/features/favorites/presentation/pages/favorites_page.dart';
import 'package:mentor_hub/features/home/presentation/pages/home_page.dart';
import 'package:mentor_hub/features/mentors/presentation/pages/mentors_page.dart';
import 'package:mentor_hub/features/post/presentation/pages/upload_post_page.dart';
import 'package:mentor_hub/features/profile/presentation/pages/profile_page.dart';

class BasePage extends StatefulWidget {
  final int initialIndex;

  const BasePage({super.key, this.initialIndex = 0});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomePage(),
    MentorsPage(searchController: SearchController()),
    const UploadPostPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
      ),
    );
  }
}

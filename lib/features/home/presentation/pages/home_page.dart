import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/mentors/presentation/pages/mentors_page.dart';

import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    MentorsPage(searchController: SearchController()),
    Center(child: Text('Settings Page')),
    Center(child: Text('Favorites Page')),
    Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      // Check if Profile tab is clicked
      context.read<AuthCubit>().logout(); // Logout user
    } else {
      setState(() {
        _selectedIndex = index; // Change selected tab
      });
    }
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 5,
        title: const Text('  Home'),
        foregroundColor: Colors.black,
        actions: [
          // logout button
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadPostPage()));
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              ))
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
    // Bottom Navigation Bar
  }
}

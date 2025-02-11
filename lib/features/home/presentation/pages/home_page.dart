import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/home/presentation/components/post_tile.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_cubit.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_states.dart';

import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 4) {
      context.read<AuthCubit>().logout();
    }

    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UploadPostPage()));
    }
  }

  late final postCubit = context.read<PostCubit>();

  @override
  void initState() {
    super.initState();
    fetchAllPosts();
  }

  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleSpacing: 5,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Upload Post Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadPostPage()),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Upload Post",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // News Section
            _buildSectionTitle("Latest News"),
            _buildNewsSection(),

            // Notifications Section
            _buildSectionTitle("Notifications"),
            _buildNotifications(),

            // Interesting Ideas & Competitions
            _buildSectionTitle("Interesting Ideas & Competitions"),
            _buildCompetitions(),

            // User Posts
            _buildSectionTitle("User Posts"),
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostsLoaded) {
                  final allPosts = state.posts;

                  if (allPosts.isEmpty) {
                    return const Center(child: Text('No posts available'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allPosts.length,
                    itemBuilder: (context, index) {
                      final post = allPosts[index];

                      return PostTile(
                        post: post,
                        onDeletePressed: () => deletePost(post.id),
                      );
                    },
                  );
                } else if (state is PostsError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Upload'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }

  // News Section
  Widget _buildNewsSection() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _newsCard(
              "New Flutter Update", "Flutter 3.10 Released!", Icons.update),
          _newsCard("Dart 3.0 Features", "Explore the latest Dart changes!",
              Icons.code),
          _newsCard("Mobile Dev Trends", "AI in Mobile Development",
              Icons.trending_up),
        ],
      ),
    );
  }

  Widget _newsCard(String title, String subtitle, IconData icon) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 40),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Notifications Section
  Widget _buildNotifications() {
    return Column(
      children: [
        _notificationTile("New Comment", "Someone commented on your post"),
        _notificationTile("New Follower", "You have a new follower"),
        _notificationTile(
            "Update Available", "Check out the latest app version"),
      ],
    );
  }

  Widget _notificationTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.notifications, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  // Competitions & Ideas
  Widget _buildCompetitions() {
    return Column(
      children: [
        _competitionTile(
            "Hackathon 2025", "Join the biggest Flutter hackathon!"),
        _competitionTile("AI Challenge", "Develop an AI-powered mobile app"),
      ],
    );
  }

  Widget _competitionTile(String title, String description) {
    return ListTile(
      leading: const Icon(Icons.emoji_events, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
    );
  }
}

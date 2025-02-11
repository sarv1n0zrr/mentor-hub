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
  }

  // post cubit
  late final postCubit = context.read<PostCubit>();

  // on startup
  @override
  void initState() {
    super.initState();

    // fetch all posts
    fetchAllPosts();
  }

  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPosts();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        title: const Text('Home'),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // logout button
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadPostPage()),
              );
            },
            icon: const Icon(Icons.add, size: 40),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              // loading
              if (state is PostsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // loaded
              else if (state is PostsLoaded) {
                final allPosts = state.posts;

                if (allPosts.isEmpty) {
                  return const Center(
                    child: Text('No posts available'),
                  );
                }

                return ListView.builder(
                  itemCount: allPosts.length,
                  itemBuilder: (context, index) {
                    final post = allPosts[index];

                    return PostTile(
                      post: post,
                      onDeletePressed: () => deletePost(post.id),
                    );
                  },
                );
              }

              // error
              else if (state is PostsError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
    // Bottom Navigation Bar
  }
}

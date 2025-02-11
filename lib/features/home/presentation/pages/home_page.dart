import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/home/presentation/components/post_tile.dart';
import 'package:mentor_hub/features/mentors/presentation/pages/mentors_page.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_cubit.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_states.dart';
import 'package:mentor_hub/features/profile/presentation/pages/profile_page.dart';
import '../../../post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Removes shadow for a cleaner look
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black, // Black text for contrast
            fontSize: 22,
            fontWeight: FontWeight.w500, // Medium weight for a modern look
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPostPage()),
              );
            },
            icon: const Icon(Icons.add_circle_outline,
                color: Colors.black, size: 28),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
    );
  }
}

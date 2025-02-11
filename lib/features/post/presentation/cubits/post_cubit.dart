import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/post/domain/repos/post_repo.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_states.dart';

import '../../../storage/domain/storage_repo.dart';
import '../../domain/entitles/post.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({required this.postRepo, required this.storageRepo})
      : super(PostsInitial());

  Future<void> createPost(Post post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      if (imagePath != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageMobile(imagePath, post.id);
      }

      if (imageBytes != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageWeb(imageBytes, post.id);
      }

      // final newPost = post.copyWith(imageUrl: imageUrl);

      // await postRepo.createPost(newPost);
      await fetchAllPosts();
    } catch (e) {
      emit(PostsError('Failed to create posts: $e'));
    }
  }

  // fetch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostsLoading());
      print('Fetching posts...'); // Debugging
      final posts = await postRepo.fetchAllPosts();
      print('Posts fetched: ${posts.length}'); // Debugging
      emit(PostsLoaded(posts));
    } catch (e) {
      print('Error fetching posts: $e'); // Debugging
      emit(PostsError('Failed to fetch posts: $e'));
    }
  }

  // delete a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
      fetchAllPosts();
    } catch (e) {
      emit(PostsError('Failed to delete post: $e'));
    }
  }
}

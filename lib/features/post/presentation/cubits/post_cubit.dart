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

  // create a new post
  Future<void> createPost(Post post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    // handle image upload for mobile platforms (using file path)
    try {
      if (imagePath != null) {
        emit(PostsUploading());
        imageUrl =
            await storageRepo.uploadProfileImageMobile(imagePath, post.id);
      }

      // handle image upload for web platforms (using file bytes)
      if (imageBytes != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadProfileImageWeb(imageBytes, post.id);
      }

      // give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      // create post in the backend
      postRepo.createPost(newPost);
    } catch (e) {
      emit(PostsError('Failed to create posts: $e'));
    }
  }

  // fetch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostsLoading());
      final posts = await postRepo.fetchAllPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError('Failed to fetch posts: $e'));
    }
  }

  // delete a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
    } catch (e) {}
  }
}

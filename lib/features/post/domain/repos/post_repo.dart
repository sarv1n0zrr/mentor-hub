import '../entitles/post.dart';

abstract class PostRepo {
  Future<List<Post>> fetchAllPosts();
  Future<void> createPost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> fetchPostsByUserId(String userId);
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../post/domain/entitles/post.dart';
import '../../../post/presentation/cubits/post_cubit.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onDeletePressed;

  const PostTile(
      {super.key, required this.post, required this.onDeletePressed});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late final postCubit = context.read<PostCubit>();
  bool isOwnPost = false;
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    isOwnPost = (widget.post.userId == currentUser?.uid);
  }

  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDeletePressed?.call();
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile_image.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Maden Aianu",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "2 days ago",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isOwnPost)
                  IconButton(
                    onPressed: showOptions,
                    icon: const Icon(Icons.more_vert),
                  ),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 330,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Make corners rounded
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Clip image to rounded shape
              child: CachedNetworkImage(
                imageUrl: widget.post.imageUrl ?? '',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 300,
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/post_image.jpg',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Post Caption
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '',
              style: const TextStyle(fontSize: 14),
            ),
          ),

          // Like, Comment, View Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
                const Text("Like"),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined),
                ),
                const Text("Comment"),
                const Spacer(),
                const Icon(Icons.visibility, size: 20, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  "500 viewers",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              'Maden Aiaru',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 15),
            child: const Text(
              'Сәлемм жас айтишник! Сенде қатысқың келеді бірақ командаң жоқпа онда маған жаз бірге команда құрамыз.',
              style: TextStyle(),
            ),
          )
        ],
      ),
    );
  }
}

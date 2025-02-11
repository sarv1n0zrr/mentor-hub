import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../post/domain/entitles/post.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onDeletePressed;
  const PostTile(
      {super.key, required this.post, required this.onDeletePressed});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // ✅ Fixed here
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDeletePressed!();
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.post.userName),
            IconButton(
                onPressed: widget.onDeletePressed,
                icon: const Icon(Icons.delete))
          ],
        ),
        CachedNetworkImage(
          imageUrl: widget.post.imageUrl,
          height: 430,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(height: 430),
          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
        ),
      ],
    );
  }
}

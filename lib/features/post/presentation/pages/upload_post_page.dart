import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_textfield.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mentor_hub/features/post/domain/entitles/post.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_cubit.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_states.dart';

import '../../../auth/domain/entities/app_user.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // mobile image pick
  PlatformFile? imagePickedFile;

  // web image pick
  Uint8List? webImage;

  // text controller -> caption
  final textController = TextEditingController();

  // current user
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // get current user
  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  // select image
  Future<void> pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: kIsWeb);

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  // create & upload post
  void uploadPost() {
    // check if both image and caption are provided
    if (imagePickedFile == null || textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Both image and caption are required')));
      return;
    }

    // create a new post object
    final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: currentUser!.uid,
        userName: currentUser!.name,
        text: textController.text,
        imageUrl: '',
        timestamp: DateTime.now());

    // post cubit
    final postCubit = context.read<PostCubit>();

    // web upload
    if (kIsWeb) {
      postCubit.createPost(newPost, imageBytes: imagePickedFile?.bytes);
    } // mobile upload
    else {
      postCubit.createPost(newPost, imagePath: imagePickedFile?.path);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // BLOC CONSUMER -> builder + listener
    return BlocConsumer<PostCubit, PostState>(builder: (context, state) {
      // loading.. or uploading
      if (state is PostsLoading || state is PostsUploading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // build upload page
      return buildUploadedPage();
    },
        // go to previous page when upload is done && posts are loaded

        listener: (context, state) {
      if (state is PostsLoaded) {
        Navigator.pop(context);
      }
    });
  }

  Widget buildUploadedPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // upload button
          IconButton(onPressed: uploadPost, icon: const Icon(Icons.upload))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // image preview for web
            if (kIsWeb && webImage != null) Image.memory(webImage!),

            // image preview for mobile
            if (!kIsWeb && imagePickedFile != null)
              Image.file(File(imagePickedFile!.path!)),

            // pick image button
            MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: const Text('Pick image'),
            ),

            // caption text box
            MyTextfield(
                controller: textController,
                hintText: 'Caption',
                obscureText: false)
          ],
        ),
      ),
    );
  }
}

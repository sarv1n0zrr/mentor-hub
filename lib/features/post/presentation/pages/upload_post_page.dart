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
  List<PlatformFile> imagePickedFiles = [];
  List<Uint8List> webImages = [];

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
  Future<void> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true, // Allow multiple image selection
      withData: kIsWeb, // Needed for web
    );

    if (result != null) {
      setState(() {
        imagePickedFiles = result.files; // Store selected images

        if (kIsWeb) {
          webImages = imagePickedFiles.map((file) => file.bytes!).toList();
        }
      });
    }
  }

  // create & upload post
  void uploadPost() {
    // check if both image and caption are provided
    if (imagePickedFiles == null || textController.text.isEmpty) {
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
      print(state);
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
            if (kIsWeb && webImages.isNotEmpty)
              SizedBox(
                height: 200, // Limit the height
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two images per row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: webImages.length,
                  itemBuilder: (context, index) {
                    return Image.memory(
                      webImages[index],
                      height: 10,
                      fit: BoxFit.cover, // Adjust image to fit nicely
                    );
                  },
                ),
              )
            else if (!kIsWeb && imagePickedFiles.isNotEmpty)
              SizedBox(
                height: 200,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two images per row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: imagePickedFiles.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(imagePickedFiles[index].path!),
                      height: 10,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            // pick image button
            ElevatedButton(
              onPressed: pickImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Pick Image'),
            ),
            const SizedBox(
              height: 30,
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

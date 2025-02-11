import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/auth/data/repository/firebase_auth_repo.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_states.dart';
import 'package:mentor_hub/features/post/data/firebase_post_repo.dart';
import 'package:mentor_hub/features/post/presentation/cubits/post_cubit.dart';
import 'package:mentor_hub/features/storage/data/firebase_storage_repo.dart';
import 'core/theme/light_mode.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  final firebaseStorageRepo = FirebaseStorageRepo();

  final firebasePostRepo = FirebasePostsRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        // profile cubit
        // BlocProvider<ProfileCubit>(
        //     create: (context) => ProfileCubit(
        //         profileRepo: firebaseProfileRepo,
        //         storageRepo: firebaseStorageRepo))

        // post cubit
        BlocProvider<PostCubit>(
            create: (context) => PostCubit(
                postRepo: firebasePostRepo, storageRepo: firebaseStorageRepo))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode.copyWith(
          scaffoldBackgroundColor: Colors.transparent,
        ),
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ], // Gradient colors
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: child,
          );
        },
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}

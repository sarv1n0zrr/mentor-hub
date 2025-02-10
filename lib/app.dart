import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/auth/data/firebase_auth_repo.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_states.dart';
import 'package:mentor_hub/features/post/data/firebase_post_repo.dart';
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
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(builder: (context, authState) {
          print(authState);
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
            // listens for any errors.....
            listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }),
      ),
    );
  }
}

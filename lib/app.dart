import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/auth/data/repository/firebase_auth_repo.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_states.dart';
import 'core/theme/light_mode.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/home_page.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
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
            listener: (context, state) {}),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_states.dart';
import 'package:mentor_hub/features/auth/presentation/pages/auth_page.dart';
import 'package:mentor_hub/features/auth/presentation/pages/login_page.dart';
import '../../data/profile_repo_impl.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../components/profile_menu_option.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(repository: ProfileRepositoryImpl())..add(LoadProfile()),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(togglePages: AuthPage.new)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                icon: const Icon(Icons.logout),
              )
            ],
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  return _buildProfileContent(state);
                } else {
                  return Center(child: Text("Failed to load profile"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(ProfileLoaded state) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/images/profile.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(state.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(state.role,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
        SizedBox(height: 20),
        ProfileMenuOption(icon: Icons.person, text: "Edit profile"),
        ProfileMenuOption(icon: Icons.bar_chart, text: "My status"),
        ProfileMenuOption(icon: Icons.settings, text: "Settings"),
        ProfileMenuOption(icon: Icons.group, text: "Invite a friend"),
        ProfileMenuOption(icon: Icons.help, text: "Help"),
      ],
    );
  }
}

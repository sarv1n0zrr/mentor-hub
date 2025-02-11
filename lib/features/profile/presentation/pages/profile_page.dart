import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: Scaffold(
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
    );
  }

  Widget _buildProfileContent(ProfileLoaded state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.arrow_back, size: 28),
              Spacer(),
              Icon(Icons.camera_alt_outlined, size: 28),
            ],
          ),
        ),
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
        ProfileMenuOption(icon: Icons.bar_chart, text: "My stats"),
        ProfileMenuOption(icon: Icons.settings, text: "Settings"),
        ProfileMenuOption(icon: Icons.group, text: "Invite a friend"),
        ProfileMenuOption(icon: Icons.help, text: "Help"),
      ],
    );
  }
}

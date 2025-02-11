abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String role;
  final String avatarUrl;

  ProfileLoaded(
      {required this.name, required this.role, required this.avatarUrl});
}

class ProfileError extends ProfileState {}

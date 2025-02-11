import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/profile_repo.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileLoading()) {
    on<LoadProfile>((event, emit) async {
      try {
        final profile = await repository.getProfile();
        emit(ProfileLoaded(
          name: profile["name"]!,
          role: profile["role"]!,
          avatarUrl: profile["avatarUrl"]!,
        ));
      } catch (_) {
        emit(ProfileError());
      }
    });
  }
}

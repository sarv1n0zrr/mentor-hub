import '../domain/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Map<String, String>> getProfile() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating API call
    return {
      "name": "Alison Danis",
      "role": "UX/UI Designer",
      "avatarUrl": "https://example.com/avatar.png",
    };
  }
}

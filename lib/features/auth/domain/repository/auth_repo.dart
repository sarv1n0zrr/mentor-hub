import 'package:mentor_hub/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password, String udesc, String role);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_hub/features/auth/domain/entities/app_user.dart';
import 'package:mentor_hub/features/auth/domain/repository/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          name: '',
          email: email,
          role: '',
          udesc: '');
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email,
      String password, String udesc, String role) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          role: role,
          udesc: udesc);
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return Future.value(null);
    }

    return Future.value(
      AppUser(
        uid: firebaseUser.uid,
        name: '',
        email: firebaseUser.email!,
        role: '',
        udesc: '',
      ),
    );
  }
}

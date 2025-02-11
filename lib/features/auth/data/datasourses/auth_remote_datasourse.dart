import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/app_user.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource({
    required this.firebaseAuth,
    required this.firestore,
  });

  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        role: '',
        udesc: '',
      );
      await firestore.collection('users').doc(user.uid).set(user.toJson());
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> updateUserInfo(
      String uid, String role, String udesc, String? subject) async {
    await firestore.collection('users').doc(uid).update({
      'role': role,
      'udesc': udesc,
      if (role == 'mentor' && subject != null) 'subject': subject,
    });
  }
}

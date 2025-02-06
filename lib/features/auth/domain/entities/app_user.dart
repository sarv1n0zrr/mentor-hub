class AppUser {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String udesc;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.udesc,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'udesc': udesc,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      name: jsonUser['name'],
      email: jsonUser['email'],
      role: jsonUser['role'],
      udesc: jsonUser['udesc'],
    );
  }
}

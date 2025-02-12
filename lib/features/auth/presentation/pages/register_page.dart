import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_button.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_textfield.dart';
import 'package:mentor_hub/features/auth/presentation/pages/user_info_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({Key? key, required this.togglePages}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  Future<void> registerUser() async {
    // Validate that passwords match
    if (pwController.text != confirmPwController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      // Create a new user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pwController.text,
      );

      // Build basic user data (do not store the password in Firestore)
      final userData = {
        "name": nameController.text,
        "email": emailController.text,
      };

      // Store the basic user registration data in Firestore using the UID as the document ID
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userData, SetOptions(merge: true));

      // Navigate to UserInfoPage to complete the registration process
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserInfoPage()),
      );
    } catch (e) {
      // Handle errors (for example, email already in use, weak password, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.jpg',
                    width: 250,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Let's create an account",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyTextfield(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    controller: pwController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    controller: confirmPwController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    onTap: registerUser,
                    text: 'Continue',
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.togglePages,
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

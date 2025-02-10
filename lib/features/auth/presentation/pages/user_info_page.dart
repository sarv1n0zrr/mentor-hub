import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_button.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_textfield.dart';
import '../components/my_dropdown.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController descriptionController = TextEditingController();
  String selectedRole = 'Student';
  String? selectedSubject;

  final List<String> subjects = [
    'Flutter',
    'HTML/CSS',
    'English',
    'IELTS',
    'Math',
    'SAT',
  ];

  void saveUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // This should not occur because the user has been registered and is signed in.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not authenticated")),
      );
      return;
    }

    final uid = user.uid;

    // Build additional user information
    Map<String, dynamic> userInfo = {
      'role': selectedRole,
      'description': descriptionController.text,
    };

    // If the user is a Mentor, include the selected subject
    if (selectedRole == 'Mentor' && selectedSubject != null) {
      userInfo['subject'] = selectedSubject;
    }

    try {
      // Update the user document in Firestore using the UID as the document ID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userInfo, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User info saved successfully")),
      );
      // You can navigate to another page (e.g., HomePage) or simply pop this page
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving user info: $e")),
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
                  Text(
                    "Let's finish registration!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyDropDown<String>(
                    value: selectedRole,
                    items: ['Student', 'Mentor'],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                        selectedSubject = null;
                      });
                    },
                    hint: 'Select Role',
                  ),
                  const SizedBox(height: 10),
                  if (selectedRole == 'Mentor')
                    MyDropDown<String>(
                      value: selectedSubject ?? subjects.first,
                      items: subjects,
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value;
                        });
                      },
                      hint: 'Select Subject',
                    ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    controller: descriptionController,
                    hintText: 'Describe yourself',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyButton(onTap: saveUserInfo, text: 'Save'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

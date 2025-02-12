import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_button.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_textfield.dart';
import '../components/my_dropdown.dart';
import 'package:mentor_hub/features/home/presentation/pages/home_page.dart'; // Import your actual home page

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not authenticated")),
      );
      return;
    }

    final uid = user.uid;

    Map<String, dynamic> userInfo = {
      'role': selectedRole,
      'description': descriptionController.text,
    };

    if (selectedRole == 'Mentor' && selectedSubject != null) {
      userInfo['subject'] = selectedSubject;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userInfo, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User info saved successfully")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_button.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_textfield.dart';
import '../../data/datasourses/auth_remote_datasourse.dart';
import '../components/my_dropdown.dart';

class UserInfoPage extends StatefulWidget {
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
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await AuthRemoteDataSource(
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      ).updateUserInfo(
          uid, selectedRole, descriptionController.text, selectedSubject);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
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
                const SizedBox(
                  height: 25,
                ),
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
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                MyTextfield(
                    controller: descriptionController,
                    hintText: 'Describe yourself',
                    obscureText: false),
                SizedBox(height: 20),
                MyButton(onTap: saveUserInfo, text: 'Save'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_button.dart';
import 'package:mentor_hub/features/auth/presentation/components/my_textfield.dart';
import 'package:mentor_hub/features/auth/presentation/cubits/auth_cubit.dart';

import '../../../home/presentation/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();
  final justController = TextEditingController();

  //register button pressed
  void register() {
    //prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;
    final String just = justController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure the fields are not empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      // ensure password match
      if (pw == confirmPw) {
        authCubit.register(name, email, confirmPw, pw, just);
      }
      // passwords do not match
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match!')));
      }
    }
    // fields are empty -> display error
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all fields')));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Let's create an account",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextfield(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  controller: pwController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  controller: confirmPwController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                SizedBox(height: 25),
                MyButton(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  text: 'Continue',
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
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
    );
  }
}

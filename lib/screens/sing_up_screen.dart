import 'package:flutter/material.dart';
import 'package:home_manager/screens/home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hi!, Welcome aboard!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Please Sign up to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Username',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text != "" &&
                    _passwordController.text != "") {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Username/Password cannot be empty')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Already have an Account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Log In"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

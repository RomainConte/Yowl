import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:yowl/screens/home_screen.dart';
import 'package:yowl/screens/register_screen.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Handle empty fields gracefully.
      // You can show a message to the user or simply return.
      return;
    }

    final url = Uri.parse('http://10.0.2.2:1337/api/auth/local');
    try {
      final response = await http.post(
        url,
        body: {
          'identifier': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
  // Parse the response body to extract user ID
  final Map<String, dynamic> responseData = json.decode(response.body);
  final int userId = responseData['user']['id'];

  // Pass the userId to the HomeScreen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
  );
      } else {
        // Handle specific error cases here, e.g., invalid credentials.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle network errors here.
      print('Error: $e');
    }
  }

  void navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: navigateToRegisterScreen,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

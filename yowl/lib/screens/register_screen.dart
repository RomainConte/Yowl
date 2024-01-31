import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yowl/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  Future<void> register(BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:1337/api/auth/local/register');
    final response = await http.post(
      url,
      body: {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'naissance': birthdateController.text,
        'confirmed': 'true'
      },
    );

     if (response.statusCode == 200) {
      // Login successful, navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }  else {
      // Handle registration error
      // TODO: Show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: birthdateController,
              decoration: InputDecoration(
                labelText: 'Birthdate',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

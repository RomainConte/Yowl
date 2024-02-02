import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yowl/screens/home_screen.dart';
import 'package:yowl/screens/register_screen.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:yowl/static.dart';

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

    final url = Uri.parse('http://$ipAdress/api/auth/local');
    try {
      final response = await http.post(
        url,
        body: {
          'identifier': emailController.text,
          'password':
              sha256.convert(utf8.encode(passwordController.text)).toString(),
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
            title: Text('La connection a échoué'),
            content: Text('Votre email ou mot de passe est incorrect'),
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
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 202, 202, 202),
                            blurRadius: 10,
                            offset: Offset(0, 2.5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 202, 202, 202),
                            blurRadius: 10,
                            offset: Offset(0, 2.5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(241, 185, 28, 1),
                          onPrimary: Colors.white,
                          elevation: 3,
                          maximumSize: const Size.fromWidth(200)),
                      onPressed: login,
                      child: Text('Se connecter'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          elevation: 2,
                          maximumSize: const Size.fromWidth(200)),
                      onPressed: navigateToRegisterScreen,
                      child: const Text('S\'inscrire'),
                    ),
                  ),
                ],
              ),
            ],
            // )
            // ],
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);
  Size get preferredSize => const Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      // backgroundColor: Colors.white,
      title: const Text('Se connecter'),
      centerTitle: true,
    );
  }
}

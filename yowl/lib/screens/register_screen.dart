import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yowl/screens/login_screen.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:yowl/static.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  // for the utf8.encode method

  Future<void> register(BuildContext context) async {
    final url = Uri.parse('http://$ipAdress/api/auth/local/register');

    final response = await http.post(
      url,
      body: {
        'username': usernameController.text,
        'email': emailController.text,
        'password':
            sha256.convert(utf8.encode(passwordController.text)).toString(),
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
    } else {
      // Handle registration error
      // TODO: Show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: "Nom d'utilisateur",
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
                            labelText: "Mot de passe",
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
                          controller: birthdateController,
                          decoration: const InputDecoration(
                            labelText: "Date de naissance",
                            hintText: "AAAA-MM-JJ",
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
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
                        onPressed: () => register(context),
                        child: Text('S\'inscrire'),
                      ),
                    ),
                  ],
                ),
              ],
              // ),
              // ],
            ),
          ),
        ));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);
  Size get preferredSize => const Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      title: const Text('S\'inscrire'),
      centerTitle: true,
    );
  }
}

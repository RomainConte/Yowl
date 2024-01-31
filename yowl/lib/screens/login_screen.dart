import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yowl/screens/home_screen.dart';
import 'package:yowl/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final url = Uri.parse('http://10.0.2.2:1337/api/auth/local');
    final response = await http.post(
      url,
      body: {
        'identifier': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Login successful, navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Login failed, show error message
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
  }

  // Function to navigate to the RegisterScreen
  void navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 50),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
            )
          ],
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
      // backgroundColor: Colors.white,
      title: const Text('Se connecter'),
      centerTitle: true,
    );
  }
}

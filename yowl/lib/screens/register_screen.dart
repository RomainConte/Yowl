import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:password_strength/password_strength.dart';
import 'package:yowl/screens/login_screen.dart';
import 'package:yowl/static.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  bool acceptConditions = false;
  bool acceptPrivacyPolicy = false;

  void showPasswordPolicyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Politique de mot de passe'),
          content: Text(
            'Votre mot de passe doit comporter au moins 8 caractères, avec des lettres majuscules, des chiffres et des caractères spéciaux.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> register(BuildContext context) async {
    final password = passwordController.text;
    final birthdateString = birthdateController.text;
    DateTime? birthdate;

    // Try to parse the birthdate
    try {
      birthdate = DateTime.parse(birthdateString);
    } catch (e) {
      // Show error if the birthdate is invalid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Format de date de naissance invalide. Utilisez AAAA-MM-JJ.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Calculate age
    final currentDate = DateTime.now();
    int age = currentDate.year - birthdate.year;
    final isBirthdayPassed = currentDate.month > birthdate.month || (currentDate.month == birthdate.month && currentDate.day >= birthdate.day);
    if (!isBirthdayPassed) {
      age--;
    }

    // Check if user is under 18
    if (age < 18) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inscription refusée'),
            content: Text('Vous devez avoir au moins 18 ans pour vous inscrire.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (!isPasswordStrong(password)) {
      showPasswordPolicyDialog();
      return;
    }

    if (!acceptConditions) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Veuillez accepter les conditions générales d\'utilisation.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final url = Uri.parse('http://$ipAdress/api/auth/local/register');

    final response = await http.post(
      url,
      body: {
        'username': usernameController.text,
        'email': emailController.text,
        'password': sha256.convert(utf8.encode(password)).toString(),
        'birthdate': birthdateController.text,
        'confirmed': 'true',
      },
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur s\'est produite lors de l\'enregistrement.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool isPasswordStrong(String password) {
    final strength = estimatePasswordStrength(password);
    return strength > 0.3;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Au moins 8 caractères, avec des lettres majuscules, des chiffres et des caractères spéciaux",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
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
              SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: acceptConditions,
                    onChanged: (value) {
                      setState(() {
                        acceptConditions = value!;
                      });
                    },
                  ),
                  Text('J\'accepte les conditions générales d\'utilisation'),
                ],
              ),
              //SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: acceptPrivacyPolicy,
                    onChanged: (value) {
                      setState(() {
                        acceptPrivacyPolicy = value!;
                      });
                    },
                  ),
                  Text('J\'accepte la politique de confidentialité'),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(241, 185, 28, 1),
                        onPrimary: Colors.white,
                        elevation: 3,
                        maximumSize: const Size.fromWidth(200),
                      ),
                      onPressed: () => register(context),
                      child: Text('S\'inscrire'),
                    ),
                  ),
                ],
              ),
            ],
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
      title: const Text('S\'inscrire'),
      centerTitle: true,
    );
  }
}

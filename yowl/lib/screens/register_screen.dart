import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:password_strength/password_strength.dart'; // Ajout de la dépendance
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

  // for the utf8.encode method

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

    if (!isPasswordStrong(password)) {
      // Le mot de passe n'est pas assez fort
      showPasswordPolicyDialog();
      return;
    }

    // Le mot de passe est assez fort, continuer avec l'enregistrement

    if (!acceptConditions) {
      // L'utilisateur n'a pas accepté les conditions générales d'utilisation
      // Afficher un message d'erreur à l'utilisateur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text(
                'Veuillez accepter les conditions générales d\'utilisation.'),
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
        'naissance': birthdateController.text,
        'confirmed': 'true',
      },
    );

    if (response.statusCode == 200) {
      // Enregistrement réussi, naviguer vers la page de connexion
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      // Gérer l'erreur d'enregistrement
      // Afficher un message d'erreur à l'utilisateur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content:
                Text('Une erreur s\'est produite lors de l\'enregistrement.'),
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
    // Vous pouvez ajuster ces valeurs en fonction de la force souhaitée
    return strength >
        0.3; // Exemple : Le mot de passe est fort si la force est supérieure à 0.3
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

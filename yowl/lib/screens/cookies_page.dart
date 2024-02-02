import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookiePage extends StatefulWidget {
  @override
  _CookiePageState createState() => _CookiePageState();
}

class _CookiePageState extends State<CookiePage> {
  bool allowCookies = true;

  @override
  void initState() {
    super.initState();
    _loadCookiesPreference();
  }

  _loadCookiesPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      allowCookies = prefs.getBool('allowCookies') ?? true;
    });
  }

  _saveCookiesPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('allowCookies', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres des cookies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
    SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Autoriser les cookies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: allowCookies,
              onChanged: (value) {
                setState(() {
                  allowCookies = value;
                });
                _saveCookiesPreference(value);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Les cookies sont de petits fichiers texte stockés sur votre appareil par votre navigateur Web. Ils jouent un rôle essentiel dans la personnalisation de l\'expérience de l\'utilisateur en ligne. La gestion des cookies vous permet de contrôler les préférences de l\'utilisateur concernant leur utilisation.',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
            Text(
              'Autoriser les Cookies',
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),
        Text(
          'L\'option "Autoriser les cookies" vous permet de déterminer si vous souhaitez autoriser l\'utilisation de cookies pendant votre navigation. Les cookies peuvent inclure des informations telles que les préférences de langue, les sessions utilisateur, et d\'autres données utiles pour améliorer l\'expérience utilisateur.',
          style: TextStyle(fontSize: 16),
        ),
            SizedBox(height: 20),
            Text(
              'En activant cette option, vous consentez à l\'utilisation de cookies qui contribuent à la personnalisation du contenu, à l\'analyse du trafic et à d\'autres fonctionnalités nécessaires au bon fonctionnement du site. Cela peut inclure des cookies tiers utilisés par des partenaires de confiance pour des services spécifiques.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Désactiver les Cookies',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Si vous choisissez de désactiver les cookies, certaines fonctionnalités du site peuvent être limitées. Par exemple, vous pourriez ne pas bénéficier de la sauvegarde de vos préférences linguistiques ou de l\'accès à des contenus personnalisés. Cependant, votre anonymat peut être préservé, car aucune information n\'est stockée localement.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'La gestion des cookies vous offre le contrôle sur la manière dont les données sont collectées et utilisées. Vous pouvez ajuster vos préférences à tout moment en accédant à la page des paramètres des cookies.Nous respectons votre vie privée et nous nous engageons à vous fournir des options transparentes pour gérer votre expérience en ligne.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ),
    );

  }
}

void main() {
  runApp(MaterialApp(
    home: CookiePage(),
  ));
}

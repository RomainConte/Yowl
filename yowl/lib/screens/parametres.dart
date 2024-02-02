import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            SingleChildScrollView(
            child: Column(
              children: <Widget>[
              Card(
                color: Colors.blueGrey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.cookie),
                      title: const Text('Cookies'),
                      onTap: () {
                        Navigator.pushNamed(context, '/cookies');

                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Confidentialité du compte'),
                      onTap: () {
                        // Naviguer vers la page des paramètres de confidentialité
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      leading: const Icon(Icons.block),
                      title: const Text('Bloqué'),
                      onTap: () {
                        // Naviguer vers la page des paramètres de confidentialité
                      },
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.blueGrey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Langue'),
                      onTap: () {
                        // Naviguer vers la page de mon compte
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      leading: const Icon(Icons.stars),
                      title: const Text('Certifications'),
                      onTap: () {
                        // Naviguer vers la page des paramètres de confidentialité
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      leading: const Icon(Icons.download_sharp),
                      title: const Text('Téléchargements'),
                      onTap: () {
                        // Naviguer vers la page des paramètres de confidentialité
                      },
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.blueGrey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child:  Column(

                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Conditions générales d\'utilisation'),
                      onTap: () {
                        Navigator.pushNamed(context, '/cgu');
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip),
                      title: const Text('Politique de confidentialité'),
                      onTap: () {
                        Navigator.pushNamed(context, '/politique');
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      leading: const Icon(Icons.mail),
                      title: const Text('Support'),
                      onTap: () {
                        Navigator.pushNamed(context, '/support');
                      },
                  ),
                ],
              ),
            ),

            Card(
              color: Colors.blueGrey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: const Text('Accessibilité'),
                    onTap: () {
                      // Naviguer vers la page de mon compte
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Statut du compte'),
                    onTap: () {
                      // Naviguer vers la page des paramètres de confidentialité
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_moon),
                    title: const Text('Ne pas déranger'),
                    onTap: () {
                      // Naviguer vers la page des paramètres de confidentialité
                    },
                ),
              ],
            ),
          ),
          // Ajoutez plus de cartes comme celle-ci pour plus de paramètres
        ],
      ),
      ),
    ),
    );

  }
}
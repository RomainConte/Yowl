import 'package:flutter/material.dart';

class PolitiquePage extends StatelessWidget {
  const PolitiquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de confidentialité'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Politique de Confidentialité de WildHub',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Introduction",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Bienvenue sur WildHub, le réseau social qui récompense l'engagement envers la cause animale. Cette politique de confidentialité a pour but de vous informer sur la manière dont nous collectons, utilisons, partageons et protégeons vos données personnelles, et sur vos droits en tant qu'utilisateur.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Collecte des Données",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Lors de votre inscription sur WildHub, nous collectons les données suivantes : - Données obligatoires : nom d'utilisateur, email, mot de passe, et date de naissance. - Données facultatives : nom, prénom, biographie. - Informations de navigation (avec votre consentement) : pour le ciblage publicitaire et la recommandation de contenu.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Utilisation des Données",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Vos données sont utilisées pour : - Vous fournir nos services et améliorer votre expérience utilisateur. - Communiquer avec vous concernant votre compte ou nos services. - Ciblage publicitaire et recommandations personnalisées (avec votre consentement).",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Partage des Données",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Vos données peuvent être partagées avec : - Les autorités locales, en cas de demande légale. - Nos partenaires commerciaux, dans le cadre de notre activité.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Sécurité des données",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Vos données sont cryptées pour assurer leur sécurité. Elles sont stockées temporairement et supprimées automatiquement après 3 ans d'inactivité de votre compte.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Durée de conservation de vos données",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Notre public",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Droits des Utilisateurs",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Conformément au RGPD et aux lois françaises, vous avez le droit de : - Accéder, rectifier ou supprimer vos données personnelles. - Modifier votre consentement à tout moment via un bouton dans le menu dépliant de votre profil.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Cookies et traceurs",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Nous utilisons des cookies et des technologies similaires pour améliorer votre expérience sur notre site. Vous pouvez gérer vos préférences en matière de cookies dans les paramètres de votre navigateur.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Mise à jour de la Politique de confidentialité",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Nous nous réservons le droit de modifier cette politique. Vous serez informé de toute modification importante par email un mois à l'avance. Votre consentement sera renouvelé suite à ces modifications.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "Consentement",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Votre consentement est obtenu en cochant les cases appropriées lors de votre inscription et lors de la modification de vos paramètres de confidentialité.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 32),
              Text(
                "Pour toute question ou préoccupation concernant cette politique de confidentialité, veuillez nous contacter à dpo@wildhub.com.",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

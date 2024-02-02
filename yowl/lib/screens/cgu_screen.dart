import 'package:flutter/material.dart';

class CGUPage extends StatelessWidget {
  const CGUPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CGU'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Conditions Générales d\'Utilisation de WildHub',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "1. Définitions et Objectifs du Réseau Social",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "WildHub est un réseau social dédié à soutenir les associations agissant en faveur de la condition animale. Notre objectif est de créer une communauté engagée où l'utilisation de l'application permet aux utilisateurs de récompenser l'association de leur choix pour leur engagement envers la cause animale.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "2. Inscription et Comptes Utilisateurs",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Pour rejoindre WildHub, les utilisateurs doivent être âgés d'au moins 15 ans. L'inscription nécessite un nom d'utilisateur, un mot de passe, une adresse email et une date de naissance. Les utilisateurs peuvent également fournir, s'ils le souhaitent, leur nom, prénom et une biographie. Ils sont responsables des informations qu'ils partagent en dehors des données exigées lors de l'inscription.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "3. Contenu Publié par les Utilisateurs",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Les contenus illicites, à caractère sexuel, incitant à la violence, ou maltraitant les animaux sont formellement interdits. Le respect mutuel est exigé ; tout acte ou propos discriminatoire, quelle que soit sa nature, est interdit et passible de sanctions.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "4. Droits d'Auteur et Propriété Intellectuelle",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Les utilisateurs doivent citer les sources des contenus qu'ils publient. Si les images ou vidéos sont créées par l'utilisateur, il détient tous les droits sur celles-ci et peut exiger le retrait de copies non autorisées de son contenu.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "5. Modération et Signalement",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Les utilisateurs ne respectant pas les règles établies peuvent être signalés. L'équipe de WildHub analysera chaque signalement et prendra des sanctions adaptées à la gravité de la situation, allant de l'avertissement avec retrait du contenu à la suppression du compte.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "6. Respect de la Vie Privée et Protection des Données",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Les données personnelles sont collectées avec le consentement de l'utilisateur et conservées temporairement, avec suppression automatique après 3 ans d'inactivité du compte. Les données peuvent être rectifiées ou supprimées à tout moment conformément au RGPD.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "7. Publicité et Promotion",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Les publicités doivent, si possible, être en accord avec la défense de la cause animale ou, au minimum, ne pas nuire à cette cause. WildHub se réserve le droit de supprimer toute publicité contraire à nos valeurs.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "8. Responsabilité Légale et Limitations",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "WildHub n'assume aucune responsabilité pour les publications et propos de ses utilisateurs. Nous nous engageons à appliquer notre politique de sanctions en cas de non-respect des règles.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "9. Modifications des CGU",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Toute modification des CGU sera communiquée par email à tous les utilisateurs au moins un mois avant son application effective, avec demande de renouvellement du consentement.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "10. Résolution des Conflits et Juridiction",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Tout conflit est soumis aux lois européennes et françaises en vigueur.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16),
              Text(
                "11. Suspension et Résiliation de Compte",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Le compte peut être suspendu ou supprimé en fonction de la gravité des infractions aux CGU. Après trois violations, le compte sera supprimé et l'utilisateur interdit de revenir sur WildHub pendant 5 ans.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 32),
              Text(
                "En utilisant WildHub, vous acceptez ces Conditions Générales d'Utilisation. Nous vous remercions de rejoindre notre communauté engagée pour la cause animale.",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

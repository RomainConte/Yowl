import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Image.asset(
              'assets/ban.png',
              width: 430,
              height: 180,
            ),
          ),
          SizedBox(height: 18),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _ProfileInfoRow(),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              children: [
                SizedBox(
                  width: 112,
                  height: 112,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/photo de profil.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'John Doe',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final int subscriberCount = 1000; // Nombre d'abonnés
  final int pointCount = 500; // Nombre de points

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$subscriberCount Abonnés',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '$pointCount Points',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

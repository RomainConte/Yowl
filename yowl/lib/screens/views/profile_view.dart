import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:1337/api/users?populate=*'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        return List<dynamic>.from(responseData['data']);
      } else {
        throw Exception('Expected key "data" not found in response');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

final int nameProfile = 

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
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),
          Align(
            alignment:
                Alignment.centerLeft, // Adjusted alignment to center left
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: SizedBox(
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
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'jean-michel',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _ProfileInfoRow(),
            ),
          ),

          const SizedBox(height: 10),
          Text(
            'Latest Trophies',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _TrophyWidget(
                trophyImage: AssetImage('assets/trophée.png'),
              ),

            ],
          ),

          // ...
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
class _TrophyWidget extends StatelessWidget {
  const _TrophyWidget({
    Key? key,
    required this.trophyImage,
  }) : super(key: key);

  final ImageProvider trophyImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image(image: trophyImage),
    );
  }
}


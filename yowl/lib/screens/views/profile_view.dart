import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileView extends StatefulWidget {
  final int userId;
  const ProfileView({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<Map<String, dynamic>> fetchUser() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:1337/api/users/${widget.userId}?populate=*'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return Map<String, dynamic>.from(responseData);
    } else {
      throw Exception('Failed to load user');
    }
  }

}
Widget buildPostGrid(List<dynamic> posts) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // number of items per row
      crossAxisSpacing: 4, // horizontal space between items
      mainAxisSpacing: 4, // vertical space between items
    ),
    itemCount: posts.length,
    itemBuilder: (context, index) {
      return Image.network(
        posts[index]['image_url'],
        fit: BoxFit.cover,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(

                                onTap: () {
                                  Navigator.pushNamed(context, "/paramètres");
                                },
                                child: const Center(
                                  child: Text(
                                    'Paramètres',
                                    style: TextStyle(fontSize: 28.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40.0),
                              GestureDetector(
                                onTap: () {
                                  print('Menu Item 2 clicked');
                                },
                                child: const Center(
                                  child: Text(
                                    'Menu Items 2',
                                    style: TextStyle(fontSize: 28.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                      )
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;

            final ImageProvider<Object> profileImage =
                    user['pp_url'] != null
                        ? NetworkImage(user['pp_url'] as String)
                        : const AssetImage('../../../assets/photo de profil.png')
                            as ImageProvider<Object>;
            final ImageProvider<Object> bannerImage =
                    user['banner_url'] != null
                        ? NetworkImage(user['banner_url'] as String)
                        : const AssetImage('../../../assets/banner.png')
                            as ImageProvider<Object>;

            return Column(
              children: [
                Image.network(
                  user['banner_url'],
                  width: 430,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 16),
                    child: SizedBox(
                      width: 112,
                      height: 112,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: profileImage,
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
                      user['username'] ?? 'Username',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: _ProfileInfoRow(),
                  ),
                ),
                const SizedBox(height: 10),

          const Text(
  'Derniers posts',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 10),
buildPostGrid(user['posts']),
          const SizedBox(height: 10),
          const Row(
            children: [
              

            ],
          ),

              ],
            );
          } else {
            return const Center(child: Text('No user found'));
          }
        },
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final int subscriberCount = 1000; // Nombre d'abonnés

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$subscriberCount Abonnés',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 10),
        
      ],
    );
  }
}

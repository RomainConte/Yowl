import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yowl/static.dart';
import 'package:yowl/screens/follower_page.dart';

class ProfileView extends StatefulWidget {
  final int userId;
  const ProfileView({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<Map<String, dynamic>> fetchUser() async {
    final response = await http.get(
        Uri.parse('http://$ipAdress/api/users/${widget.userId}?populate=*'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return Map<String, dynamic>.from(responseData);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Widget buildPostGrid(List<dynamic> posts) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        title: const Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                          padding: const EdgeInsets.all(40.0),
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
                                  Navigator.pushNamed(context, "/edit_profile",
                                      arguments: widget.userId);
                                },
                                child: const Center(
                                  child: Text(
                                    'Modifier le profil',
                                    style: TextStyle(fontSize: 28.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: const Center(
                                  child: Text(
                                    'Se déconnecter',
                                    style: TextStyle(
                                        fontSize: 28.0, color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          )));
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              final ImageProvider<Object> profileImage = user['pp_url'] != null
                  ? NetworkImage(user['pp_url'] as String)
                  : AssetImage('../../../assets/photo de profil.png')
                      as ImageProvider<Object>;
              final ImageProvider<Object> bannerImage =
                  user['banner_url'] != null
                      ? NetworkImage(user['banner_url'] as String)
                      : AssetImage('../../../assets/banner.png')
                          as ImageProvider<Object>;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Image.network(
                            user['banner_url'],
                            // width: 430,
                            // height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
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
                      Expanded(child: Container()),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ProfileInfoRow(
                            userId: widget.userId
                                , // Convert to String if your userId is an int
                            ipAddress:
                                ipAdress, // Assuming ipAdress is a global variable
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            user['bio'] ?? 'Bio',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Derniers posts',
                            style: TextStyle(
                              fontSize: 20,
                              // Text(
                              //   'Derniers posts',
                              //   style: TextStyle(
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //buildPostGrid(user['posts']),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        child: buildPostGrid(user['posts']),
                      ),
                    ],
                  ),
                ],
              );
              // const SizedBox(height: 10),
              // buildPostGrid(user['posts']),
              // const SizedBox(height: 10),
              // Row(
              //   children: [],
              // ),
              // ),
              // ],
              // );
            } else {
              return Center(child: Text('No user found'));
            }
          },
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatefulWidget {
  final int userId;
  final String ipAddress;

  const ProfileInfoRow(
      {Key? key, required this.userId, required this.ipAddress})
      : super(key: key);

  @override
  _ProfileInfoRowState createState() => _ProfileInfoRowState();
}

class _ProfileInfoRowState extends State<ProfileInfoRow> {
  int subscriberCount = 0; // Initialize subscriber count to 0

  @override
  void initState() {
    super.initState();
    fetchSubscriberCount();
  }

  Future<void> fetchSubscriberCount() async {
    final String urlUpdate =
        "http://${widget.ipAddress}/api/users/${widget.userId}?populate=*";
    final responseCurrentUser = await http.get(Uri.parse(urlUpdate));
    if (responseCurrentUser.statusCode == 200) {
      final currentUserData = jsonDecode(responseCurrentUser.body);
      List userList = [];
      if (currentUserData['followers'] != null) {
        currentUserData['followers'].forEach((element) {
          userList.add(element['id']);
        });
      }

      setState(() {
        subscriberCount = userList.length; // Update subscriber count
      });
    } else {
      // Handle the error; perhaps show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
          '$subscriberCount ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        InkWell(
              onTap: () {
                // Placez ici votre logique de navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowersPage(userId:widget.userId)), // Remplacez NouvellePage par votre page de destination
                );
              },
              child: Text(
                'Abonnés',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline, // Optionnel: souligne le texte pour indiquer qu'il est cliquable
                ),
              ),
            ),
          ],
        )
        
      ],
    );
  }
}


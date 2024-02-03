import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yowl/static.dart';

class OtherProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;
  final int userId; // Assuming this is the ID of the current user

  const OtherProfilePage({Key? key, required this.user, required this.userId}) : super(key: key);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
  }

  Future<void> checkIfFollowing() async {
    // Fetch current user's profile to check if they're following the viewed profile
    final String urlCurrentUser = "http://$ipAdress/api/users/${widget.userId}?populate=*";
    final responseCurrentUser = await http.get(Uri.parse(urlCurrentUser));

    if (responseCurrentUser.statusCode == 200) {
      final currentUserData = jsonDecode(responseCurrentUser.body);
      List userList = [];
      currentUserData['abonnements'].forEach((element) {
        userList.add(element['id']);
      });
      setState(() {
        isFollowing = userList.contains(widget.user['id']);
      });
    } else {
      print('Erreur lors de la requête GET');
    }
  }

  Future<void> toggleFollow() async {
    final bool shouldFollow = !isFollowing;
    final String urlUpdate = "http://$ipAdress/api/users/${widget.userId}?populate=*";
    final responseCurrentUser = await http.get(Uri.parse(urlUpdate));
    final currentUserData = jsonDecode(responseCurrentUser.body);
    List userList = [];
    currentUserData['abonnements'].forEach((element) {
      userList.add(element['id']);
    });

    if (shouldFollow) {
      // Follow the user
      userList.add(widget.user['id']);
      final responseUpdate = await http.put(
        Uri.parse(urlUpdate),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "abonnements": userList,
        }),
      );

      if (responseUpdate.statusCode == 200) {
        setState(() {
          isFollowing = shouldFollow;
        });
      } else {
        print('Erreur lors de la mise à jour');
      }
    } else {
      // Unfollow the user
      userList.remove(widget.user['id']);
      final responseUpdate = await http.put(
        Uri.parse(urlUpdate),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "abonnements": userList,
        }),
      );

      if (responseUpdate.statusCode == 200) {
        setState(() {
          isFollowing = shouldFollow;
        });
      } else {
        print('Erreur lors de la mise à jour');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['username'] ?? ''),
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
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text(
                                'Bloquer',
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
                                'Menu Item 2',
                                style: TextStyle(fontSize: 28.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(
                widget.user['banner_url'] ?? '',
                width: 430,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: SizedBox(
                  width: 112,
                  height: 112,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user['pp_url'] ?? ''),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      widget.user['username'] ?? 'Username',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => toggleFollow(),
                      child: Text(isFollowing ? 'Ne plus suivre' : 'S\'abonner'),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _ProfileInfoRow(ipAddress: ipAdress, userId: widget.user['id']),

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
            buildPostGrid(widget.user['posts']),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatefulWidget {
  final String ipAddress;
  final int userId;

  const _ProfileInfoRow({Key? key, required this.ipAddress, required this.userId}) : super(key: key);

  @override
  _ProfileInfoRowState createState() => _ProfileInfoRowState();
}

class _ProfileInfoRowState extends State<_ProfileInfoRow> {
  int subscriberCount = 0; // Initialize subscriber count to 0

  @override
  void initState() {
    super.initState();
    fetchSubscriberCount();
  }

  Future<void> fetchSubscriberCount() async {
    final String urlUpdate = "http://${widget.ipAddress}/api/users/${widget.userId}?populate=*";
    final responseCurrentUser = await http.get(Uri.parse(urlUpdate));
    if (responseCurrentUser.statusCode == 200) {
      final currentUserData = jsonDecode(responseCurrentUser.body);
      List userList = [];
      if (currentUserData['abonnes'] != null) {
        currentUserData['abonnes'].forEach((element) {
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
        Text(
          '$subscriberCount Abonnés',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}


Widget buildPostGrid(List<dynamic> posts) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(), // Pour désactiver le défilement de GridView
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Nombre d'éléments par ligne
      crossAxisSpacing: 4, // Espace horizontal entre les éléments
      mainAxisSpacing: 4, // Espace vertical entre les éléments
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

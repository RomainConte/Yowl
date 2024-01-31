import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import 'package:yowl/static.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

  Future<List<dynamic>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://$ipAdress/api/posts?populate=*'));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WILDHUB'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else if (snapshot.hasData) {
            final userList = snapshot.data as List<dynamic>;

            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                if (userList[index] == null ||
                    userList[index]['attributes'] == null) {
                  return SizedBox.shrink(); // Skip rendering if data is null
                }

                final Map<String, dynamic> user = userList[index]['attributes'];

                // Convert createdAt to DateTime
                final DateTime createdAt = DateTime.parse(user['createdAt']);

                // Use 'pp_url' as the image for both profile and post
                final ImageProvider<Object> profileImage =
                    user['user']['data'][0]['attributes']['pp_url'] != null
                        ? NetworkImage(user['user']['data'][0]['attributes']
                            ['pp_url'] as String)
                        : AssetImage('assets/default_profile_image.png')
                            as ImageProvider<Object>;

                final ImageProvider<Object> postImage =
                    user['image_url'] != null && user['image_url'] is String
                        ? NetworkImage(user['image_url'] as String)
                        : profileImage;

                final String postImageUrl =
                    user['image_url'] != null && user['image_url'] is String
                        ? user['image_url'] as String
                        : '';

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: profileImage,
                        ),
                        title: Text(
                            '${user['user']['data'][0]['attributes']['username'] ?? 'Unknown'}'),
                        subtitle: Text(
                            'Posted ${timeago.format(createdAt, locale: 'fr')}'),
                      ),
                      user['image_url'] != null && user['image_url'] is String
                          ? Image.network(
                              postImageUrl,
                              fit: BoxFit.cover,
                              height: 300.0,
                              errorBuilder: (context, error, stackTrace) {
                                print('Image Error: $error');
                                return SizedBox(
                                  height: 300.0,
                                  child: Center(
                                    child: Text('Image not available'),
                                  ),
                                );
                              },
                            )
                          : SizedBox(height: 0),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '${user['Contenu'] ?? 'No content'}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite),
                                color: Colors.red,
                                onPressed: () {
                                  print('Like button pressed');
                                },
                              ),
                              // You can add a counter here if needed
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.chat_bubble_outline),
                                onPressed: () {
                                  print('Comment button pressed');
                                },
                              ),
                              // You can add a counter here if needed
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}

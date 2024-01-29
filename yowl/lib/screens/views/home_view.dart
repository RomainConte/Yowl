import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:1337/api/posts'));

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
        title: Text('Posts'),
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
                final user = userList[index]['attributes'];

                return ListTile(
                  leading: user['image'] != null
                      ? Image.network('https://medias.pourlascience.fr/api/v1/images/view/5a82a89a8fe56f4a615c5b35/width_300/image.jpg')
                      : SizedBox(width: 50, height: 50),
                  title: Text('Content: ${user['Contenu']}'), // Assuming 'content' is the correct key
                  subtitle: Text('Created at: ${user['createdAt']}'),
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
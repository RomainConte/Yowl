// followers_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yowl/static.dart';

class FollowersPage extends StatefulWidget {
  final int userId;

  const FollowersPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  late Future<List<dynamic>> followers;

  @override
  void initState() {
    super.initState();
    followers = fetchFollowers(widget.userId);
  }

  Future<List<dynamic>> fetchFollowers(int userId) async {
    final response = await http.get(Uri.parse('http://$ipAdress/api/users/$userId?populate=*'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['followers'] as List;
    } else {
      throw Exception('Failed to load followers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: followers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final follower = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(follower['pp_url']),
                ),
                title: Text(follower['username']),
              );
            },
          );
        },
      ),
    );
  }
}

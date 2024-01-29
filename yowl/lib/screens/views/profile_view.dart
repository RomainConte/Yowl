import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key});

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:1000/api/users'));

    if (response.statusCode == 200) {
      // Parse the JSON response as a List<dynamic> (assuming it's an array of users).
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while fetching data.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle errors if any.
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          // Handle the case where no data is available.
          return Text('No data available');
        } else if (snapshot.hasData) {
          // Display the list of users as a ListView.
          final userList = snapshot.data as List<dynamic>;

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index] as Map<String, dynamic>;

              return ListTile(
                title: Text('Name: ${user['name']}'),
                subtitle: Text('Email: ${user['email']}'),
              );
            },
          );
        } else {
          // Handle other cases.
          return Text('Something went wrong');
        }
      },
    );
  }
}

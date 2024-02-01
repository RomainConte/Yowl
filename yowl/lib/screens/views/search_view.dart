import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:yowl/static.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            height: 15,
            width: 15,
            child: Image.asset(
              'assets/logo_wild.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: 'Recherche',
            // je vais faire un rectangle derrirere le textfield
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ), // Ajoutez cette ligne
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
      body: Profil(searchText: _searchController.text),
    );
  }
}

class Profil extends StatelessWidget {
  const Profil({Key? key, required this.searchText}) : super(key: key);

  final String searchText;

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://$ipAdress/api/users'));

    if (response.statusCode == 200) {
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
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else if (snapshot.hasData) {
          final userList = snapshot.data as List<dynamic>;
          final filteredUserList = userList
              .where((user) => user['username']
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredUserList.length,
            itemBuilder: (context, index) {
              final user = filteredUserList[index] as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['pp_url'] as String),
                  radius: 20,
                ),
                title: Text(user['username']),
                //je vais faire le lien vers la page profil other screen
                onTap: () {
                  Navigator.pushNamed(context, '/profile_other',
                      arguments: user);
                },
              );
            },
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}

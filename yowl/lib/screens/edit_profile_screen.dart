import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yowl/static.dart';
import 'package:yowl/screens/home_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final int userId;

  EditProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _pp_url_Controller;
  late TextEditingController _banner_url_Controller;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    _pp_url_Controller = TextEditingController();
    _banner_url_Controller = TextEditingController();

    // Fetch user data
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final url = 'http://$ipAdress/api/users/${widget.userId}?populate=*';
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      setState(() {
        _nameController.text = data['username'];
        _emailController.text = data['email'];
        _bioController.text = data['bio'];
        _pp_url_Controller.text = data['pp_url'];
        _banner_url_Controller.text = data['banner_url'];
      });
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  Future<void> _saveProfileChanges() async {
    final url = 'http://$ipAdress/api/users/${widget.userId}';
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({

  
        "username": _nameController.text,
        "email": _emailController.text,
        "bio": _bioController.text,
        "pp_url": _pp_url_Controller.text,
        "banner_url": _banner_url_Controller.text,
      

    });

    try {
      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Profile updated successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(userId: widget.userId,cookies:true)),
        );
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to update profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Biographie',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _pp_url_Controller,
                      decoration: const InputDecoration(
                        labelText: 'URL de la photo de profil',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _banner_url_Controller,
                      decoration: const InputDecoration(
                        labelText: 'URL de la bannière',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(241, 185, 28, 1),
                  onPrimary: Colors.white,
                  elevation: 3,
                  maximumSize: const Size.fromWidth(200)),
              onPressed: () => _saveProfileChanges(),
              child: const Text('Sauvegarder'),
            ),
          ],
        ),
      ),
    );
  }
}

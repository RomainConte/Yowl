import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  EditProfilePage({required this.userProfile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userProfile.name;
    _emailController.text = widget.userProfile.email;
    _bioController.text = widget.userProfile.bio;
  }

  void _updateProfile() {
    // Call your function to update the profile details
    // For example:
    // updateProfile(widget.userProfile.id, _nameController.text, _emailController.text, _bioController.text);
    // You need to implement the updateProfile function according to your backend logic.
    // Remember to handle success and error cases accordingly.
    // After a successful update, you might want to navigate back to the profile page.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  final String id;
  String name;
  String email;
  String bio;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
  });
}

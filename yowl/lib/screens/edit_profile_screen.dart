import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile userProfile;
  final Function(UserProfile) onProfileUpdated;

  EditProfilePage({required this.userProfile, required this.onProfileUpdated});

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
    // Update the profile details in the original UserProfile object
    widget.userProfile.name = _nameController.text;
    widget.userProfile.email = _emailController.text;
    widget.userProfile.bio = _bioController.text;

    // Call the callback function to notify the profile has been updated
    widget.onProfileUpdated(widget.userProfile);

    // Navigate back to the profile page
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

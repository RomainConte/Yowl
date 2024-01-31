import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const OtherProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['username'] ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("https://images.pexels.com/photos/14803768/pexels-photo-14803768.jpeg"),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text('Username: ${widget.user['username'] ?? ''}'),
            const SizedBox(height: 8),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}

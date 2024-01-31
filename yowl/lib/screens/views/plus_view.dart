import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlusView extends StatefulWidget {
  final int userId;
  const PlusView({Key? key, required this.userId}) : super(key: key);

  @override
  _PlusViewState createState() => _PlusViewState();
}

class _PlusViewState extends State<PlusView> {
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  Future<void> _handlePublishButtonPress() async {
    final url = Uri.parse('http://10.0.2.2:1337/api/posts?populate=*');

    final Map<String, String> requestData = {
      'image_url': imageUrlController.text,
      'Contenu': captionController.text,
      'user': widget.userId.toString(),
    };

    final requestBody = json.encode({"data": requestData});

    final response = await http.post(
      url,
      body: requestBody,
      headers: {"Content-Type": "application/json"}, // Set the content type header
    );

    if (response.statusCode == 200) {
      // TODO: Handle successful response
      print('Post created successfully');
    } else {
      // TODO: Handle error response
      print('Error creating post: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: captionController,
              decoration: InputDecoration(
                labelText: 'Caption',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _handlePublishButtonPress();
              },
              child: Text('Publish'),
            ),
          ],
        ),
      ),
    );
  }
}

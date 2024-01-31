import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yowl/static.dart';

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
    final url = Uri.parse('http://$ipAdress/api/posts?populate=*');

    final Map<String, String> requestData = {
      'image_url': imageUrlController.text,
      'Contenu': captionController.text,
      'user': widget.userId.toString(),
    };

    final requestBody = json.encode({"data": requestData});

    final response = await http.post(
      url,
      body: requestBody,
      headers: {
        "Content-Type": "application/json"
      }, // Set the content type header
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
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        // child: Padding(
        //   padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: imageUrlController,
                      decoration: InputDecoration(
                        labelText: 'Image',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 202, 202, 202),
                          blurRadius: 10,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: captionController,
                      decoration: InputDecoration(
                        labelText: 'Légende',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(241, 185, 28, 1),
                        onPrimary: Colors.white,
                        elevation: 3,
                        maximumSize: const Size.fromWidth(200)),
                    onPressed: () {
                      _handlePublishButtonPress();
                    },
                    child: Text('Publier'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Nouvelle publication'),
      centerTitle: true,
    );
  }
}

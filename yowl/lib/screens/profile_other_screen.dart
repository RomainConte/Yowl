import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yowl/screens/home_screen.dart';
import 'package:yowl/screens/views/search_view.dart';

class OtherProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const OtherProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['username'] ?? ''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Padding(padding: const EdgeInsets.all(40.0),
                        child: Column(
                        children: <Widget>[
                          GestureDetector(
                          // onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const HomeScreen()), (route) => false),

                          child: const Center(
                            child: Text(
                              'Bloquer',
                              style: TextStyle(fontSize: 28.0),
                            ),
                          ),
                        ),
                          const SizedBox(height: 40.0),
                          GestureDetector(
                            onTap: () {
                              print('Menu Item 2 clicked');
                            },
                            child: const Center(
                              child: Text(
                                'Menu Items 2',
                                style: TextStyle(fontSize: 28.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    )
                  );
                },
              );
            },
          ),
        ],
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

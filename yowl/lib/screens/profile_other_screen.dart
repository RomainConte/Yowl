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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
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
                                'Menu Item 2',
                                style: TextStyle(fontSize: 28.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.network(
                      widget.user['banner_url'],
                      // width: 430,
                      // height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: SizedBox(
                  width: 112,
                  height: 112,
                  child: CircleAvatar(
                    // Replace with actual image source
                    backgroundImage: NetworkImage(widget.user['pp_url'] ?? ''),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      widget.user['username'] ?? 'Username',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: _ProfileInfoRow(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Derniers posts',
                      style: TextStyle(
                        fontSize: 20,
// fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: buildPostGrid(widget.user['posts']),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Additional widgets or content can be added here
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final int subscriberCount = 1000; // Nombre d'abonnés

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$subscriberCount Abonnés',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

Widget buildPostGrid(List<dynamic> posts) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // number of items per row
      crossAxisSpacing: 4, // horizontal space between items
      mainAxisSpacing: 4, // vertical space between items
    ),
    itemCount: posts.length,
    itemBuilder: (context, index) {
      return Image.network(
        posts[index]['image_url'],
        fit: BoxFit.cover,
      );
    },
  );
}

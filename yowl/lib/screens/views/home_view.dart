import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends StatefulWidget {
  final int userId;

  const HomeView({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late int currentUserId;
  late String currentUserUsername;
  List<dynamic>? posts;

  @override
  void initState() {
    super.initState();
    currentUserId = widget.userId;
    fetchPosts(currentUserId);
  }

  Future<void> fetchPosts(int userId) async {
    print('Fetching posts for userId: $userId');

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:1337/api/posts?populate=*&userId=$userId'),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          setState(() {
            posts = List<dynamic>.from(responseData['data']);
          });

          // Récupérer le nom d'utilisateur à partir du premier post (s'il y a des posts)
          if (responseData['data'].isNotEmpty) {
            currentUserUsername = responseData['data'][0]['attributes']['user']['data'][0]['attributes']['username'];
          }
        } else {
          print('Invalid response format: $responseData');
        }
      } else {
        print('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('WILDHUB'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: posts == null
          ? Center(child: CircularProgressIndicator())
          : posts!.isEmpty
          ? Center(child: Text('No data available'))
          : ListView.builder(
        itemCount: posts!.length,
        itemBuilder: (context, index) {
          final post = posts![index];

          if (post == null || post['attributes'] == null) {
            return SizedBox.shrink(); // Skip rendering if data is null
          }

          final Map<String, dynamic> postData = post['attributes'];

          // Convert createdAt to DateTime
          final DateTime createdAt = DateTime.parse(postData['createdAt']);

          // Use 'pp_url' as the image for both profile and post
          final ImageProvider<Object> profileImage =
          postData['user']['data'][0]['attributes']['pp_url'] != null
              ? NetworkImage(postData['user']['data'][0]['attributes']['pp_url'] as String)
              : AssetImage('assets/default_profile_image.png') as ImageProvider<Object>;

          final ImageProvider<Object> postImage =
          postData['image_url'] != null && postData['image_url'] is String
              ? NetworkImage(postData['image_url'] as String)
              : profileImage;

          final String postImageUrl =
          postData['image_url'] != null && postData['image_url'] is String
              ? postData['image_url'] as String
              : '';

          // Extract the likes data
          final List<dynamic>? likesData = postData['likes']['data'];

          // Get the IDs of users who liked the post
          final List<int> likedUserIds =
              likesData?.map<int>((like) => like['id'] as int).toList() ?? [];

          // Check if the current user liked the post
          final bool isLiked = likedUserIds.contains(currentUserId);

          return Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: profileImage,
                  ),
                  title: Text(
                      '${postData['user']['data'][0]['attributes']['username'] ?? 'Unknown'}'),
                  subtitle: Text('Posted ${timeago.format(createdAt, locale: 'fr')}'),
                ),
                postData['image_url'] != null && postData['image_url'] is String
                    ? Image.network(
                  postImageUrl,
                  fit: BoxFit.cover,
                  height: 300.0,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image Error: $error');
                    return SizedBox(
                      height: 300.0,
                      child: Center(
                        child: Text('Image not available'),
                      ),
                    );
                  },
                )
                    : SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${postData['Contenu'] ?? 'No content'}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LikeButton(
                      likes: likesData,
                      isLiked: isLiked,
                      onLike: () => handleLike(post['id'], isLiked),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          onPressed: () {
                            print('Comment button pressed');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> handleLike(int postId, bool isLiked) async {
    try {
      if (isLiked) {
        // Unlike post
        final response = await http.put(
          Uri.parse('http://10.0.2.2:1337/api/posts/$postId'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'data': {
              'likes': [], // Envoyer un tableau vide pour supprimer tous les likes
            },
          }),
        );

        print('Response for post $postId unlike: ${response.statusCode} - ${response.body}');

        if (response.statusCode == 200) {
          print('Post $postId unliked by user $currentUserId');
          fetchPosts(currentUserId);
        } else {
          print('Failed to unlike post $postId. Status code: ${response.statusCode}');
        }
      } else {
        // Like post
        final response = await http.put(
          Uri.parse('http://10.0.2.2:1337/api/posts/$postId'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'data': {
              'likes': [
                {
                  'id': currentUserId,
                  'username': currentUserUsername,
                }
              ],
            },
          }),
        );

        print('Response for post $postId like: ${response.statusCode} - ${response.body}');

        if (response.statusCode == 200) {
          print('Post $postId liked by user $currentUserId');
          fetchPosts(currentUserId);
        } else {
          print('Failed to like post $postId. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Failed to handle like/unlike for post $postId. Error: $e');
    }
  }
}

class LikeButton extends StatefulWidget {
  final List<dynamic>? likes;
  final bool isLiked;
  final VoidCallback onLike;

  const LikeButton({Key? key, this.likes, required this.isLiked, required this.onLike})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isLiked ? Icons.favorite : Icons.favorite_border,
        color: widget.isLiked ? Colors.red : null,
      ),
      onPressed: widget.onLike,
    );
  }
}

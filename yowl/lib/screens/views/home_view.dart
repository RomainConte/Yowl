import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import 'package:yowl/static.dart';

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
        Uri.parse('http://$ipAdress/api/posts?populate=*&userId=$userId'),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          setState(() {
            posts = List<dynamic>.from(responseData['data']);
          });

          // Retrieve the username from the first post (if there are posts)
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

  Future<List<dynamic>?> fetchComments(int postId) async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:1337/api/commentaires?populate=*&filters%5B%24and%5D%5B0%5D%5Bpost%5D%5Bid%5D%5B%24eq%5D=$postId"),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          return List<dynamic>.from(responseData['data']);
        } else {
          print('Invalid response format: $responseData');
          return null;
        }
      } else {
        print('Failed to load comments for post $postId');
        return null;
      }
    } catch (e) {
      print('Error fetching comments: $e');
      return null;
    }
  }

  Future<void> _navigateToCommentsPage(int postId) async {
    // Retrieve comments for this post
    List<dynamic>? commentsData = await fetchComments(postId);

    // Navigate to the comments page with the comments data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          currentUserUsername: currentUserUsername,
          commentsData: commentsData,
          postId: postId,
          currentUserId: currentUserId,
          onCommentSubmitted: (newComment) {
            // Place the code to execute when the comment is submitted here.
            // You can, for example, refresh the list of comments.
          },
        ),
      ),
    );
  }

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
              height: 20,
              width: 20,
              child: Image.asset(
              'assets/logo_wild.png',
              fit: BoxFit.cover,
              ),
            ),
          ),
        title: Text('WILDHUB'),
        centerTitle: true,

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
          final ImageProvider<Object>? profileImage =
          postData['user']['data'][0]['attributes']['pp_url'] != null
              ? NetworkImage(postData['user']['data'][0]['attributes']['pp_url'] as String) as ImageProvider<Object>?
              : AssetImage('assets/default_profile_image.png') as ImageProvider<Object>?;

          final ImageProvider<Object>? postImage = postData['image_url'] != null &&
              postData['image_url'] is String
              ? NetworkImage(postData['image_url'] as String) as ImageProvider<Object>?
              : profileImage;

          final String postImageUrl = postData['image_url'] != null && postData['image_url'] is String
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
                    '${postData['content'] ?? 'No content'}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LikeButton(
                      postId: post['id'],
                      likes: likesData,
                      isLiked: isLiked,
                      onLike: () => handleLike(post['id'], isLiked),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          onPressed: () {
                            _navigateToCommentsPage(post['id']);
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
              'likes': [],
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
  final int postId;
  final List<dynamic>? likes;
  final bool isLiked;
  final VoidCallback onLike;

  const LikeButton({Key? key, required this.postId, this.likes, required this.isLiked, required this.onLike})
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

class CommentsScreen extends StatefulWidget {
  final String currentUserUsername;
  final List<dynamic>? commentsData;
  final Function(String) onCommentSubmitted;
  final int postId;
  final int currentUserId;

  CommentsScreen(
      {Key? key,
        required this.currentUserUsername,
        required this.commentsData,
        required this.onCommentSubmitted,
        required this.postId,
        required this.currentUserId})
      : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();

  Future<void> postComment(String newComment) async {
    try {
      // Send the new comment to the API with postId and userId
      final response = await http.post(
        Uri.parse('http://$ipAdress/api/commentaires'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'data': {
            'content': newComment,
            'post': widget.postId,
            'users_permissions_user': widget.currentUserId,
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Comment added successfully');
        // Refresh the interface with the new comment
        setState(() {
          widget.commentsData?.add({
            'username': widget.currentUserUsername,
            'text': newComment,
          });
        });
        // Call the callback function
        widget.onCommentSubmitted(newComment);
        // Clear the comment field
        commentController.clear();
      } else {
        print('Failed to add comment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commentaires'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.commentsData?.length ?? 0,
              itemBuilder: (context, index) {
                final comment = widget.commentsData?[index];
                if (comment != null && comment["attributes"] != null) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:NetworkImage( comment["attributes"]["users_permissions_user"]["data"]["attributes"]['pp_url'] as String),
                    ),
                    title: Text(comment["attributes"]["users_permissions_user"]["data"]["attributes"]['username'] ?? 'Unknown User'),
                    subtitle: Text(comment["attributes"]['content'] ?? ''),
                  );
                } else {
                  return SizedBox.shrink(); // Skip rendering if data is null
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Ajouter un commentaire...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String newComment = commentController.text;

                    if (newComment.isNotEmpty) {
                      await postComment(newComment);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

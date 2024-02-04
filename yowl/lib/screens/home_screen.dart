import 'package:flutter/material.dart';
import 'package:yowl/screens/views/home_view.dart';
import 'package:yowl/screens/views/profile_view.dart';
import 'package:yowl/screens/views/search_view.dart';
import 'package:yowl/screens/views/plus_view.dart';
import 'package:yowl/screens/cookies_page.dart'; // Make sure you have this view created for showing cookies policy

class HomeScreen extends StatefulWidget {
  final int userId;
  bool cookies = false; // Assuming this variable will be updated based on user's choice

  HomeScreen({Key? key, required this.userId, this.cookies = false}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.cookies) {
        _showCookiesDialog();
      }
    });
  }

  void _showCookiesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Politique de cookies"),
          content: Text("Acceptez vous notre politique de cookies ?"),
          actions: <Widget>[
            TextButton(
              child: Text("Voir la politique"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CookiePage()), // Navigate to cookies policy page
                );
              },
            ),
            TextButton(
              child: Text("Accepter"),
              onPressed: () {
                setState(() {
                  widget.cookies = true; // Update the state to reflect the user's choice
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Refuser"),
              onPressed: () {
                setState(() {
                  widget.cookies = true; // Update the state to reflect the user's choice
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
        children: <Widget>[
          HomeView(userId: widget.userId), // Pass userId if needed

          SearchView(userId: widget.userId,), // Pass userId if needed
          PlusView(userId: widget.userId), // Pass userId if needed

          ProfileView(userId: widget.userId), // Pass userId to ProfileView
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(241, 185, 28, 1),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(_selectedIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Publier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
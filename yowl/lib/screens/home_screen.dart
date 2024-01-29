import 'package:flutter/material.dart';
import 'package:yowl/screens/views/home_view.dart';
import 'package:yowl/screens/views/profile_view.dart';
import 'package:yowl/screens/views/search_view.dart';
import 'package:yowl/screens/views/totem_view.dart';
import 'package:yowl/screens/views/plus_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _selectedIndex = 1;

@override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
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
        children: const <Widget> [
        HomeView(),
        SearchView(),
        PlusView(),
        TotemView(),
        ProfileView(),
      ]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange, // This will make the selected icon orange
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });

            _pageController.jumpToPage(_selectedIndex);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hdr_plus, color: Colors.black),
              label: 'Plus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Totem',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}
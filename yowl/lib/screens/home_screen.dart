import 'package:flutter/material.dart';
import 'package:yowl/screens/views/home_view.dart';
import 'package:yowl/screens/views/profile_view.dart';
import 'package:yowl/screens/views/search_view.dart';
import 'package:yowl/screens/views/totem_view.dart';
import 'package:yowl/screens/views/plus_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({Key? key,}) : super(key: key);

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
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });

            _pageController.jumpToPage(_selectedIndex);
          },
          items:  const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Plus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Totem',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}
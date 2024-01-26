import 'package:flutter/material.dart';
import 'package:yowl/secondpage.dart';

import 'homepage.dart';


void main() {
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: const Text('WildHub'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const IconButton(
          icon: Icon(
            Icons.person,
            color : Colors.black,
            size: 40,
          ),
          onPressed: null
        ),
      ),
      body: [
        const HomePage(),
        const SecondPage(),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setCurrentIndex(index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Second',
          ),
        ],
      ),
      ),
    );
  }
}


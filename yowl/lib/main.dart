import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music player',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
        elevation: 0,
        leading: const IconButton(
          icon: Icon(
      Icons.menu,
      color : Colors.black,
      ),
      onPressed: null,
      ),
      ),
      body: const Center(
        child: Text('Home page'),
      ),
    );
  }
}
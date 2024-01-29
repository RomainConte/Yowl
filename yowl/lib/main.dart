import 'package:flutter/material.dart';
import 'package:yowl/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Guigui Hub',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


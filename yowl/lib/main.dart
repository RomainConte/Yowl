
import 'package:flutter/material.dart';
import 'package:yowl/screens/home_screen.dart';
import 'package:yowl/screens/profile_other_screen.dart';
// import 'package:yowl/screens/views/search_view.dart';
import 'package:yowl/screens/login_screen.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildHub',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialRoute: '/',
      routes: {
        // '/search': (context) => const SearchView(),
        '/profile_other': (context) {
          final Map<String, dynamic> user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return OtherProfilePage(user: user);
        },
      },

    );
  }
}
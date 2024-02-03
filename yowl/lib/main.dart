import 'package:flutter/material.dart';
import 'package:yowl/screens/cookies_page.dart';
import 'package:yowl/screens/home_screen.dart';
import 'package:yowl/screens/parametres.dart';
import 'package:yowl/screens/politique_screen.dart';
import 'package:yowl/screens/profile_other_screen.dart';
import 'package:yowl/screens/login_screen.dart';
import 'package:yowl/screens/support_screen.dart';
import 'package:yowl/screens/views/profile_view.dart';
import 'package:yowl/screens/edit_profile_screen.dart';
import 'screens/cgu_screen.dart';

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
        '/cookies': (context) => CookiePage(),
        '/login': (context) => LoginScreen(),
        '/home': (context) {
          final int userId = ModalRoute.of(context)!.settings.arguments as int;
          return HomeScreen(userId: userId);
        },
        '/edit_profile': (context) {
          final int userId = ModalRoute.of(context)!.settings.arguments as int;
          return EditProfileScreen(userId: userId);
        },
        '/support': (context) => SupportPage(),
        '/cgu': (context) => const CGUPage(),
        '/politique': (context) => const PolitiquePage(),
        '/paramètres': (context) => const SettingsPage(),
        '/profile_other': (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments is Map<String, dynamic>) {
      final user = arguments['user'] as Map<String, dynamic>; // Profile being viewed
      final int userId = arguments['userId'] as int; // Logged-in user's ID
      
      return OtherProfilePage(user: user, userId: userId);
    } else {
      throw Exception('Invalid arguments for /profile_other route. Expected a Map with user and userId.');
    }
  },
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';
import '../screens/home_screen.dart'; 
import 'TechHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String userRole = prefs.getString('userRole') ?? '';

  runApp(MyApp(isLoggedIn: isLoggedIn, userRole: userRole));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String userRole;

  MyApp({required this.isLoggedIn, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      initialRoute: isLoggedIn 
          ? (userRole == 'Técnico' ? '/tech_home' : '/home_screen')
          : '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home_screen': (context) => const HomePage(),  
        '/tech_home': (context) => TechHomepage(),
      },
    );
  }
}




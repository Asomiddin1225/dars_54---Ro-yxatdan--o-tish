
import 'package:dars_54/view_models/users_viewmodel.dart';
import 'package:dars_54/views/screens/homePage.dart';
import 'package:dars_54/views/screens/home_screen.dart';
import 'package:dars_54/views/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final usersViewModel = UsersViewmodel();

  bool isLogged = false;

  @override
  void initState() {
    super.initState();

    usersViewModel.checkLogin().then((value) {
      setState(() {
        isLogged = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: isLogged ? const HomePage() : const LoginScreen(),
    );
  }
}
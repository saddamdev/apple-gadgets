import 'package:flutter/material.dart';
import 'package:apple_gadgets_bd/screens/loading_screen.dart';
import 'package:apple_gadgets_bd/screens/sign_in_screen.dart';
import 'package:apple_gadgets_bd/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apple Gadgets BD',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/login': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

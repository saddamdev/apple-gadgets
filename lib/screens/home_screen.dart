import 'package:flutter/material.dart';
import 'package:apple_gadgets_bd/screens/account_screen.dart';
import 'package:apple_gadgets_bd/screens/trade_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final screens = const [TradeScreen(), AccountScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.insights_outlined), label: 'Trades'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: 'Account'),
        ],
      ),
    );
  }
}

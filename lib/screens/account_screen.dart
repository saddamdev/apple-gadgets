// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:apple_gadgets_bd/services/api_service.dart';

const getAccountInformation = 'GetAccountInformation';
const getLastFourNumbersPhone = 'GetLastFourNumbersPhone';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String name = '';
  String country = '';
  double balance = 0;
  int totalTradesCount = 0;
  String last4Number = '';

  Future<void> getUserInfo() async {
    final accountInfo = await getData(getAccountInformation);
    final phoneNumber = await getData(getLastFourNumbersPhone);
    setState(() {
      name = accountInfo['name'];
      country = accountInfo['country'];
      balance = accountInfo['balance'];
      totalTradesCount = accountInfo['totalTradesCount'];
      last4Number = phoneNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> logOut() async {
    final user = await Hive.openBox('userBox');
    user.put('isLoggedIn', false);

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 1), // Shadow position
                  ),
                ]),
            child: Column(
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.green,
                  size: 64,
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Balance: ${balance.toStringAsFixed(2)}'),
                    Text('Total Trades: ${totalTradesCount.toString()}'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Country: $country'),
                    Text('Phone: $last4Number'),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: logOut,
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}

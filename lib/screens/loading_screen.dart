// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:apple_gadgets_bd/services/api_service.dart';

const getAccountInformation = 'GetAccountInformation';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> checkAccess() async {
    final statusCode = await checkUserAccess(getAccountInformation);

    if (statusCode != 200) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checkAccess();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('L O A D I N G...'),
      ),
    );
  }
}

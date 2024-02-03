// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

const base = 'https://peanut.ifxdb.com/api/ClientCabinetBasic/';
const isAccountCredentialsCorrect = 'IsAccountCredentialsCorrect';

const header = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
};

Future<int> signIn(String id, String pass) async {
  const endPoint = base + isAccountCredentialsCorrect;

  final url = Uri.parse(endPoint);

  final userId = int.parse(id);

  final body = jsonEncode({
    'login': userId,
    'password': pass,
  });

  try {
    final res = await http.post(url, headers: header, body: body);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final user = await Hive.openBox('userBox');
      user.put('id', userId);
      user.put('isLoggedIn', data['result']);
      user.put('token', data['token']);
    }

    return res.statusCode;
  } catch (e) {
    print(e);
    return -1;
  }
}

Future getData(String endPoint) async {
  final url = Uri.parse(base + endPoint);

  final user = await Hive.openBox('userBox');

  final userId = user.get('id');
  final token = user.get('token');

  final body = jsonEncode({
    'login': userId,
    'token': token,
  });

  try {
    final res = await http.post(url, headers: header, body: body);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data;
    }
  } catch (e) {
    print(e);
  }
}

Future<int> checkUserAccess(String endPoint) async {
  final url = Uri.parse(base + endPoint);

  final user = await Hive.openBox('userBox');

  final userId = user.get('id') ?? 123;
  final token = user.get('token') ?? '579';
  final isLoggedIn = user.get('isLoggedIn') ?? false;

  if (!isLoggedIn) {
    return -1;
  }

  final body = jsonEncode({
    'login': userId,
    'token': token,
  });

  try {
    final res = await http.post(url, headers: header, body: body);

    return res.statusCode;
  } catch (e) {
    print(e);
    return -1;
  }
}

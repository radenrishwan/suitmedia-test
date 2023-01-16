import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magang/models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];
  int page = 1;

  final String endpoint = 'https://reqres.in/api';

  Future<int> fetchUsers() async {
    final response = await http.get(Uri.parse('$endpoint/users?page=$page&per_page=10'));

    if (response.statusCode != 200) {
      throw const HttpException('Failed to load users');
    }

    final data = jsonDecode(response.body)['data'] as List;

    for (var element in data) {
      users.add(User.fromJson(element));
    }

    notifyListeners();

    return data.length;
  }

  Future<int> loadMore() async {
    page++;
    final result = await fetchUsers();
    return result;
  }
}

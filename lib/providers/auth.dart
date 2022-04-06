import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate; // A token expires after certain amount of time.
  String? userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCU6Vu9SAF_jsH1vX7xEd-Iz7cAheMcij4');
    final response = await http.post(
      url,
      body: json.encode(
        {"email": email, "password": password, "returnSecureToken": true},
      ),
    );
  }
}

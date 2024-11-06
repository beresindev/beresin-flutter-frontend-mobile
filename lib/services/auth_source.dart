import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/login_model.dart';
import 'package:http/http.dart' as http;

class AuthFuture {
  Future<LoginModel> login(String email, String password, String token) async {
    try {
      final response = await http.post(
        Uri.parse("{ApiConstants.baseUrl}${ApiConstants.loginEndpoint}"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "fcm_token": token,
        }),
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return LoginModel.fromJson(responseData);
      } else {
        throw Exception("Failed to login: ${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }
}

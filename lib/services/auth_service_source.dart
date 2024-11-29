import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_beresin/models/user_model.dart';

class AuthService {
  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AuthModel.fromJson(responseData);
      } else {
        throw Exception("Failed to login: ${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthModel> register({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "username": username,
          "name": name,
          "email": email,
          // "phone": '0$phone',
          "phone": phone.startsWith('0') ? phone : '0$phone',
          "password": password,
        }),
      );
      debugPrint(response.body);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return AuthModel.fromJson(responseData);
      } else {
        log('qq error');
        throw "Failed to register: ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile(String token) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.getProfileEndpoint}';
    var headers = {
      // 'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      log(token);
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      log(response.body);

      if (response.statusCode == 200) {
        log("kode 200");
        final data = jsonDecode(response.body)['user'];
        log("Request successful in service");
        return UserModel.fromJson(data);
      } else {
        log("Error in service");
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      log("Exception caught: $e");
      rethrow;
    }
  }
}

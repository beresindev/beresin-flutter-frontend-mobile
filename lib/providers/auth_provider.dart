import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/models/login_model.dart';
import 'package:mobile_beresin/services/auth_source.dart';

class AuthProvider extends ChangeNotifier {
  final tokenManager = TokenManager();
  LoginModel? _user;
  LoginModel get user => _user!;

  Future<bool> login(String email, String password, String token) async {
    try {
      LoginModel? user = await AuthFuture().login(email, password, token);
      _user = user;
      tokenManager.putToken(user.token);
      log(user.toString());
      return true;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

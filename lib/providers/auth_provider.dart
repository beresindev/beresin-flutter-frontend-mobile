import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/models/login_model.dart';
import 'package:mobile_beresin/services/auth_source.dart';
import 'package:mobile_beresin/services/login_with_token.dart';

class AuthProvider extends ChangeNotifier {
  final tokenManager = TokenManager();
  AuthModel? _user;
  AuthModel get user => _user!;

  Future<bool> login(String email, String password) async {
    try {
      log("Proses login dimulai...");
      AuthModel? user = await AuthFuture().login(email, password);

      _user = user;
      log("Login berhasil, token disimpan.");

      tokenManager.putToken(user.token); // Pastikan ini tidak error
      log("Token tersimpan: ${user.token}");

      return true;
    } catch (e) {
      log("Terjadi kesalahan saat login:");
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> authWithToken({
    void Function(dynamic)? errorCallback,
  }) async {
    try {
      log("COKK");
      AuthModel result = await loginWithToken((await tokenManager.getToken())!);

      _user = result;
      tokenManager.putToken(result.token);
      notifyListeners();
      return true;
    } on SocketException {
      errorCallback?.call("TUKU PAKTEAN SEK COKKKK");
      return false;
    } catch (error) {
      errorCallback?.call(error);
      return false;
    }
  }
}

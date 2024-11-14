import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/models/auth_model.dart';
import 'package:mobile_beresin/models/user_model.dart';
import 'package:mobile_beresin/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final tokenManager = TokenManager();
  UserModel? _user;
  UserModel get user => _user!;

  Future<bool> login(String email, String password) async {
    try {
      log("Proses login dimulai...");
      AuthModel? auth = await AuthService().login(email, password);
      // await getProfile(token: auth.token);
      _user = auth.user;
      notifyListeners();
      tokenManager.putToken(auth.token); // Pastikan ini tidak error
      log("Login berhasil, token disimpan.");
      log("Token tersimpan: ${auth.token}");
      return true;
    } catch (e) {
      log("Terjadi kesalahan saat login:");
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      log("Proses register dimulai...");
      AuthModel auth = await AuthService().register(
        name: name,
        username: username,
        email: email,
        phone: phone,
        password: password,
      );
      _user = auth.user;
      notifyListeners();
      // await getProfile(token: auth.token);
      tokenManager.putToken(auth.token); // Pastikan ini tidak error
      log("Register berhasil, token disimpan.");
      log("Token tersimpan: ${auth.token}");
      return true;
    } catch (e) {
      log("Terjadi kesalahan saat register:");
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> getProfile({
    required String token,
    void Function(dynamic)? errorCallback,
  }) async {
    try {
      log("COKK");
      UserModel result =
          await AuthService().getProfile((await tokenManager.getToken())!);
      _user = result;
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

import 'dart:convert';
import 'dart:developer';
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/login_model.dart';
import 'package:http/http.dart' as http;

Future<AuthModel> loginWithToken(String token) async {
  var url = '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}';
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    log(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      log("Request successful in service");
      return AuthModel.fromJson(data);
    } else {
      log("Error in service");
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    log("Exception caught: $e");
    rethrow;
  }
}

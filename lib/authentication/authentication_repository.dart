import 'dart:convert';

import 'package:asistencia_v2/api.dart';
import 'package:asistencia_v2/authentication/models/login.dart';
import 'package:asistencia_v2/authentication/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository {
  // Logins the user, returns the error, null if success
  Future<LoginResult> login(String email, String password) async {
    final response = await ApiClient.instance.post(
      "${ApiClient.BASE_URL}/login",
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    final responseData = LoginResponse.fromJson(jsonDecode(response.body));
    if (responseData.success) {
      // guardar el tokens
      final storage = FlutterSecureStorage();
      await storage.write(key: "token", value: responseData.token);
      ApiClient.instance.authorize(responseData.token);
      return LoginResult(null, responseData.user);
    } else {
      return LoginResult(responseData.err, null);
    }
  }

  Future<String> getToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    ApiClient.instance.authorize(token);
    return token;
  }

  Future<bool> isLoggedIn() async {
    return (await getToken()) != null;
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: "token");
    ApiClient.instance.authorize(null);
  }
}

class LoginResult {
  final String error;
  final UserModel user;

  LoginResult(this.error, this.user);
}

import 'package:asistencia_v2/authentication/models/user.dart';

class LoginResponse {
  final bool success;
  final String err;
  final String token;
  final UserModel user;

  LoginResponse(this.success, this.err, this.token, this.user);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json['success'],
      json['err'],
      json['token'],
      json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  @override
  String toString() {
    return "err: $err, token: $token, succcess: $success";
  }
}

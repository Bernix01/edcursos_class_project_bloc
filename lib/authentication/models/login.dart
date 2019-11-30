class LoginResponse {
  final bool success;
  final String err;
  final String token;

  LoginResponse(this.success, this.err, this.token);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(json['success'], json['err'], json['token']);
  }

  @override
  String toString() {
    return "err: $err, token: $token, succcess: $success";
  }
}

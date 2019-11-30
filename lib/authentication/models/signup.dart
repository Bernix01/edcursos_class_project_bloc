class SignUpRequest {
  final String email;
  final String password;
  final String name;

  SignUpRequest(this.email, this.password, this.name);

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": name,
    };
  }
}

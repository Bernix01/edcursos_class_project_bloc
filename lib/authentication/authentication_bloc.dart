import 'dart:convert';

import 'package:asistencia_v2/api.dart';
import 'package:asistencia_v2/authentication/authentication_event.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
import 'package:asistencia_v2/authentication/models/login.dart';
import 'package:asistencia_v2/authentication/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => UnAuthState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingAuthState();
      final String user = event.user;
      final String password = event.password;

      final response = await ApiClient.instance.post(
        "${ApiClient.BASE_URL}/login",
        body: jsonEncode({
          "email": user,
          "password": password,
        }),
      );

      final responseData = LoginResponse.fromJson(jsonDecode(response.body));

      if (responseData.success) {
        // guardar el token
        final storage = FlutterSecureStorage();
        await storage.write(key: "token",value: responseData.token);
        // yield AuthenticatedAuthState(UserModel(nombre: , esInstructor: ))
        yield ErrorAuthState("asdasd");
      } else {
        yield ErrorAuthState("${responseData.err}");
      }
      // if (event.user == "pepito" && event.password == "1234") {
      //   yield AuthenticatedAuthState(
      //       UserModel(nombre: "pepito", esInstructor: false));
      // } else {

      // }
    }
  }

  @override
  String toString() => "AutBloc";
}

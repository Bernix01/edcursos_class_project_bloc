import 'dart:convert';

import 'package:asistencia_v2/api.dart';
import 'package:asistencia_v2/authentication/authentication_event.dart';
import 'package:asistencia_v2/authentication/authentication_repository.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
import 'package:asistencia_v2/authentication/models/login.dart';
import 'package:asistencia_v2/authentication/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authRepository = AuthenticationRepository();

  @override
  AuthenticationState get initialState => UnAuthState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is CheckTokenEvent) {
      final bool isLoggedIn = await this._authRepository.isLoggedIn();
      if (isLoggedIn) {
        yield AuthenticatedAuthState(
          UserModel(
            nombre: "Pepiot",
            email: "test@email.com",
            esInstructor: true,
          ),
        );
      } else {
        yield UnauthenticatedAuthState();
      }
    }
    if (event is LoginEvent) {
      yield LoadingAuthState();
      final String user = event.user;
      final String password = event.password;
      final LoginResult result =
          await this._authRepository.login(user, password);
      if (result.error == null) {
        yield AuthenticatedAuthState(result.user);
      } else {
        yield ErrorAuthState("${result.error}");
      }
      // if (event.user == "pepito" && event.password == "1234") {
      //   yield AuthenticatedAuthState(
      //       UserModel(nombre: "pepito", esInstructor: false));
      // } else {

      // }
    }

    if (event is LogoutEvent){
      await this._authRepository.logout();
      yield UnauthenticatedAuthState();
    }
  }

  @override
  String toString() => "AutBloc";
}

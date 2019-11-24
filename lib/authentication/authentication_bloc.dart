import 'package:asistencia_v2/authentication/authentication_event.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
import 'package:asistencia_v2/authentication/models/user.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => UnAuthState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingAuthState();
      if (event.user == "pepito" && event.password == "1234") {
        yield AuthenticatedAuthState(
            UserModel(nombre: "pepito", esInstructor: false));
      } else {
        yield ErrorAuthState("Contraseña o usuario incorrectos");
      }
    }
  }

  @override
  String toString() => "AutBloc";
}

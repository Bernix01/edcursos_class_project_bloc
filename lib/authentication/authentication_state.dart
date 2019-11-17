import 'package:asistencia_v2/authentication/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  String toString();
}

class UnAuthState extends AuthenticationState {
  @override
  String toString() {
    return "UnAuthState";
  }

  @override
  List<Object> get props => [];
}

class AuthenticatedAuthState extends AuthenticationState {
  final UserModel user;

  AuthenticatedAuthState(this.user);

  @override
  String toString() {
    return "AuthenticatedAuthState { $user }";
  }

  @override
  List<Object> get props => [user];
}
class LoadingAuthState extends AuthenticationState {
  @override
  String toString() => "LoadingAuthState";

  @override
  List<Object> get props => [];

  
}
class ErrorAuthState extends AuthenticationState {
  final String error;

  ErrorAuthState(this.error);

  @override
  String toString() => "ErrorAuthState { $error }";

  @override
  List<Object> get props => [error];
}

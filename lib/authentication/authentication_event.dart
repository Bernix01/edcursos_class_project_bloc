abstract class AuthenticationEvent {
  @override
  String toString();
}

class CheckTokenEvent extends AuthenticationEvent{

  @override
  String toString() {
    return "CheckTokenEvent";
  }
}

class LoginEvent extends AuthenticationEvent {
  final String user;
  final String password;

  LoginEvent(this.user, this.password);

  @override
  String toString() => "LoginEvent { user:$user, password:$password }";
}

class LogoutEvent extends AuthenticationEvent {
  @override
  String toString() => "LogoutEvent";
}

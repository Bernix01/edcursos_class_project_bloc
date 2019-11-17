import 'package:asistencia_v2/authentication/authentication_bloc.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
import 'package:asistencia_v2/home.dart';
import 'package:asistencia_v2/login/login_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsistenciaBlocDelegate extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error.toString());
    print(stacktrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print("Event fired: Bloc: $bloc, Event: $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("Transition: Bloc: $bloc, transition: $transition");
  }
}

var delegate;
void main() {
  BlocSupervisor.delegate = AsistenciaBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistencia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthenticationBloc>(
        builder: (context) => AuthenticationBloc(),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          condition: (previous, current) =>
              !(current is ErrorAuthState) &&
              !(current is LoadingAuthState) &&
              previous != current,
          builder: (context, state) {
            if (state is UnAuthState) {
              return LoginPage();
            }
            if (state is AuthenticatedAuthState) {
              return MyHomePage(
                title: "Hola ${state.user.nombre}",
              );
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}

//MyHomePage(title: 'Flutter Demo Home Page')

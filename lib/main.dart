import 'package:asistencia_v2/asistentes_detalle.dart';
import 'package:asistencia_v2/authentication/authentication_bloc.dart';
import 'package:asistencia_v2/authentication/authentication_event.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
import 'package:asistencia_v2/root.dart';
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  @override
  void initState() {
    super.initState();
    _authenticationBloc.add(CheckTokenEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistencia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/asistentes': (context) => AsistentesDetallePage(),
      },
      home: BlocProvider<AuthenticationBloc>(
        builder: (context) => _authenticationBloc,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          condition: (previous, current) =>
              !(current is ErrorAuthState) &&
              !(current is LoadingAuthState) &&
              previous != current,
          builder: (context, state) {
            if (state is UnAuthState) {
              // El splash
              return Scaffold(
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (state is AuthenticatedAuthState) {
              return RootPage(
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

/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'package:flutter/material.dart';
import 'package:asistencia_v2/home/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  HomeBloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeBloc>(
        builder: (context) => _bloc,
        child: HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    print("disposing");
    _bloc.close();
    super.dispose();
  }
}

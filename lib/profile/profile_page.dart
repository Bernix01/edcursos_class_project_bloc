/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'package:flutter/material.dart';
import 'package:asistencia_v2/profile/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = "/profile";

  ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocProvider<ProfileBloc>(
        builder: (context) => ProfileBloc(),
        child: ProfileScreen(),
      ),
    );
  }
}

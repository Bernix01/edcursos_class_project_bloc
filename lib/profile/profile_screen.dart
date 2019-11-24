/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asistencia_v2/profile/index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (
      BuildContext context,
      ProfileState currentState,
    ) {
      if (currentState is UnProfileState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (currentState is ErrorProfileState) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentState.errorMessage ?? 'Error'),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: RaisedButton(
                color: Colors.blue,
                child: Text("reload"),
                onPressed: () => this._load(),
              ),
            ),
          ],
        ));
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Profile"),
          ],
        ),
      );
    });
  }

  void _load([bool isError = false]) {
    BlocProvider.of<ProfileBloc>(context).add(UnProfileEvent());
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent(isError));
  }
}

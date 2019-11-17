import 'package:asistencia_v2/authentication/authentication_bloc.dart';
import 'package:asistencia_v2/authentication/authentication_event.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _userTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  bool _esValido = false;

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('books')
        .document()
        .setData({'title': 'title', 'author': 'author'});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, currState) {
        if (currState is ErrorAuthState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(currState.error),
          ));
        }
        if (currState is LoadingAuthState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Cargando"),
          ));
        }
      },
      condition: (previous, current) =>
          current is ErrorAuthState || current is LoadingAuthState,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                width: 300,
                height: 300,
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Usuario"),
                      controller: _userTextEditingController,
                      onChanged: (string) {
                        setState(() {
                          _esValido = string.isNotEmpty &&
                              _passwordTextEditingController.text.isNotEmpty;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Contraseña"),
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: _passwordTextEditingController,
                      maxLength: 4,
                      onChanged: (string) {
                        setState(() {
                          _esValido = string.isNotEmpty &&
                              _userTextEditingController.text.isNotEmpty;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                    ),
                    RaisedButton(
                      child: Text("Iniciar sesión"),
                      onPressed: _esValido
                          ? () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  LoginEvent(_userTextEditingController.text,
                                      _passwordTextEditingController.text));
                            }
                          : null,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

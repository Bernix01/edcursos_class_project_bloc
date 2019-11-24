/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'package:flutter/material.dart';
import 'package:asistencia_v2/chat/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/chat";

  ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: BlocProvider<ChatBloc>(
        builder: (context) => ChatBloc(),
        child: ChatScreen(),
      ),
    );
  }
}

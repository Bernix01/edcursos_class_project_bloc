import 'package:asistencia_v2/authentication/authentication_bloc.dart';
import 'package:asistencia_v2/authentication/authentication_state.dart';
/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asistencia_v2/chat/index.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key key,
  }) : super(key: key);

  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
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
    return BlocBuilder<ChatBloc, ChatState>(builder: (
      BuildContext context,
      ChatState currentState,
    ) {
      if (currentState is UnChatState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (currentState is ErrorChatState) {
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
      final chats = (currentState as InChatState).chats;
      print("chaats $chats");
      return Container(
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              title: Text(chat.sender),
              subtitle: Text(chat.date),
            );
          },
        ),
      );
    });
  }

  void _load() {
    BlocProvider.of<ChatBloc>(context).add(UnChatEvent());
    final String userId = (BlocProvider.of<AuthenticationBloc>(context).state
            as AuthenticatedAuthState)
        .user
        .nombre;
    print("user: $userId");
    BlocProvider.of<ChatBloc>(context).add(LoadChatEvent(userId));
  }
}

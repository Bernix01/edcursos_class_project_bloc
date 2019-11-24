/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:asistencia_v2/chat/index.dart';
import 'dart:developer' as developer;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ChatState get initialState => UnChatState(0);

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChatBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

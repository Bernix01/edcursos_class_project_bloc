import 'dart:async';
import 'package:asistencia_v2/chat/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class ChatEvent {
  Stream<ChatState> applyAsync({ChatState currentState, ChatBloc bloc});
  final ChatRepository _chatRepository = ChatRepository();
}

class UnChatEvent extends ChatEvent {
  @override
  Stream<ChatState> applyAsync({ChatState currentState, ChatBloc bloc}) async* {
    yield UnChatState(0);
  }
}

class LoadChatEvent extends ChatEvent {
  final String userId;

  @override
  String toString() => 'LoadChatEvent';

  LoadChatEvent(this.userId);

  @override
  Stream<ChatState> applyAsync({ChatState currentState, ChatBloc bloc}) async* {
    try {
      if (currentState is InChatState) {
        yield currentState.getNewVersion();
      }
      yield* this._chatRepository.getChats(this.userId).map((chats) {
        print(chats);
        return InChatState(0, chats);
      });
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadChatEvent', error: _, stackTrace: stackTrace);
      yield ErrorChatState(0, _?.toString());
    }
  }
}

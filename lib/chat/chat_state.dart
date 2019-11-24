import 'package:asistencia_v2/chat/index.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final Iterable propss;
  ChatState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChatState getStateCopy();

  ChatState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChatState extends ChatState {

  UnChatState(version) : super(version);

  @override
  String toString() => 'UnChatState';

  @override
  UnChatState getStateCopy() {
    return UnChatState(0);
  }

  @override
  UnChatState getNewVersion() {
    return UnChatState(version+1);
  }
}

/// Initialized
class InChatState extends ChatState {
  final List<ChatModel> chats;

  InChatState(version, this.chats) : super(version, [chats]);

  @override
  String toString() => 'InChatState ${chats.length}';

  @override
  InChatState getStateCopy() {
    return InChatState(this.version, this.chats);
  }

  @override
  InChatState getNewVersion() {
    return InChatState(version+1, this.chats);
  }
}

class ErrorChatState extends ChatState {
  final String errorMessage;

  ErrorChatState(version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorChatState';

  @override
  ErrorChatState getStateCopy() {
    return ErrorChatState(this.version, this.errorMessage);
  }

  @override
  ErrorChatState getNewVersion() {
    return ErrorChatState(version+1, this.errorMessage);
  }
}

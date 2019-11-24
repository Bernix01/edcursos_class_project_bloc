import 'dart:async';
import 'package:asistencia_v2/profile/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class ProfileEvent {
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc});
}

class UnProfileEvent extends ProfileEvent {
  @override
  Future<ProfileState> applyAsync({ProfileState currentState, ProfileBloc bloc}) async {
    return UnProfileState(0);
  }
}

class LoadProfileEvent extends ProfileEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadProfileEvent';

  LoadProfileEvent(this.isError);

  @override
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc}) async {
    try {
      if (currentState is InProfileState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 2));
      return InProfileState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadProfileEvent', error: _, stackTrace: stackTrace);
      return ErrorProfileState(0, _?.toString());
    }
  }
}

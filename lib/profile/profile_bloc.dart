/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:asistencia_v2/profile/index.dart';
import 'dart:developer' as developer;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ProfileState get initialState => UnProfileState(0);

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

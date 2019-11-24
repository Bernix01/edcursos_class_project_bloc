/**
  *
  * Creado el 23 de noviembre de 2019
  * Por: Guillermo Bernal
  * Version de plantilla: 1.0
  *
*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:asistencia_v2/home/index.dart';
import 'dart:developer' as developer;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  Future<void> close() async {
    // dispose objects
    super.close();
  }

  HomeState get initialState => UnHomeState(0);

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HomeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

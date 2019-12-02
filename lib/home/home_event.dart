import 'dart:async';
import 'dart:convert';
import 'package:asistencia_v2/api.dart';
import 'package:asistencia_v2/home/index.dart';
import 'package:asistencia_v2/models/course.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class UnHomeEvent extends HomeEvent {
  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    return UnHomeState(0);
  }
}

class LoadHomeEvent extends HomeEvent {
  final bool isError;
  @override
  String toString() => 'LoadHomeEvent';

  LoadHomeEvent(this.isError);

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      if (currentState is InHomeState) {
        return currentState.getNewVersion();
      }
      final response =
          await ApiClient.instance.get("${ApiClient.BASE_URL}/courses");
      if (response.statusCode != 200) {
        throw Exception("No se pudieron cargar los cursos");
      }
      final Courses cursos = Courses.fromJson(jsonDecode(response.body));
      print(cursos);
      return InHomeState(0, "Hello world 2");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadHomeEvent', error: _, stackTrace: stackTrace);
      return ErrorHomeState(0, _?.toString());
    }
  }
}

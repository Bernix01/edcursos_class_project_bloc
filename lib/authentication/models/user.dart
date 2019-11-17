import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserModel extends Equatable {
  final String nombre;
  final bool esInstructor;

  const UserModel({
    @required this.nombre,
    @required this.esInstructor,
  });

  @override
  List<Object> get props => [nombre, esInstructor];
}

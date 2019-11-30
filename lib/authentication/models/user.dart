import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserModel extends Equatable {
  final String nombre;
  final String email;
  final bool esInstructor;

  const UserModel({
    @required this.nombre,
    @required this.esInstructor,
    @required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        nombre: json['name'],
        esInstructor: json['role'] == 'INSTRUCTOR',
        email: json['email']);
  }

  @override
  List<Object> get props => [email];
}

import 'package:equatable/equatable.dart';

class Courses {
  final List<Course> courses;

  Courses(this.courses);

  factory Courses.fromJson(List<dynamic> json) {
    return Courses(
      json.map((j) => Course.fromJson(j)).toList(),
    );
  }

  @override
  String toString() {
    return "Cursos: ${this.courses.length} ${this.courses.map((c) => "\n\t$c")}";
  }
}

class Course extends Equatable {
  final String name;
  final String id;
  final String date;

  Course(this.name, this.id, this.date);

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      json['name'],
      json['id'],
      json['createdAt'],
    );
  }

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return this.name;
  }
}

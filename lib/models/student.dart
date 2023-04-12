import 'dart:convert';
import 'package:equatable/equatable.dart';

class Student extends Equatable {
  Student({
    required this.id,
    required this.name,
    required this.pass,
    this.attendance,
  });
  dynamic id;
  String name;
  String pass;
  List<String>? attendance;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['_id'],
        name: json['name'],
        pass: json['pass'],
        attendance: (json['attendance'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['pass'] = pass;
    data['attendance'] = attendance;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        pass,
        attendance,
      ];
}

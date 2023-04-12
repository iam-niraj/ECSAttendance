import 'dart:convert';
import 'package:equatable/equatable.dart';

Register loginResponseJson(String str) => Register.fromJson(json.decode(str));

class Register extends Equatable {
  Register({
    required this.id,
    required this.name,
    required this.pass,
  });
  dynamic id;
  String name;
  String pass;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        id: json['_id'],
        name: json['name'],
        pass: json['pass'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['pass'] = pass;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        pass,
      ];
}
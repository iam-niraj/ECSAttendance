import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Login {
  Login({
    required this.name,
    required this.pass,
  });

  String name;
  String pass;
}
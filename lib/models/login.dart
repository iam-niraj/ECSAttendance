import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Login({
    required this.name,
    required this.pass,
  });

  String name;
  String pass;

  factory Login.fromJson(Map<String, dynamic> data) =>
      _$LoginFromJson(data);

  Map<String, dynamic> toJson() => _$LoginToJson(this);

  Login copyWith({
    String? name,
    String? pass,
  }) {
    return Login(
        name: name ?? this.name,
        pass: pass ?? this.pass,);
  }
}
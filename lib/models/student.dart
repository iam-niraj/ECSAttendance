import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  Student({
    required this.id,
    required this.name,
    required this.pass,
    required this.attendance,
  });

  ObjectId id;
  String name;
  String pass;
  List<String>? attendance;

  factory Student.fromJson(Map<String, dynamic> data) =>
      _$StudentFromJson(data);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  Student copyWith({
    ObjectId? id,
    String? name,
    String? pass,
    List<String>? attendance,
  }) {
    return Student(
      id: id ?? this.id,
        name: name ?? this.name,
        pass: pass ?? this.pass,
        attendance: attendance ?? this.attendance);
  }
}

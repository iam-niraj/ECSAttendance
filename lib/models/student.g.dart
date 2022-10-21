// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['_id'],
      name: json['name'] as String,
      pass: json['pass'] as String,
      attendance: (json['attendance'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      "_id": instance.id,
      'name': instance.name,
      'pass': instance.pass,
      'attendance': instance.attendance,
    };

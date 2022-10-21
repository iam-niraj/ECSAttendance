import 'package:ecs_attendance/database/database.dart';
import 'package:ecs_attendance/models/student.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DataTable(
            columns: const [DataColumn(label: Text("Students"))],
            rows: _students()),
      ),
    );
  }

  List<DataRow> _students() {
    List<DataRow> data = [];
    getAll();
    MongoDatabase.getDocuments().then(
      (value) {
        for (var item in value) {
          final student = Student.fromJson(item);
          String name = student.name;
          data.add(
            DataRow(
              cells: [
                DataCell(Text(name)),
              ],
            ),
          );
        }
      },
    );
    return data;
  }

  List<Student> getAll() {
    List<Student> students = [];
    MongoDatabase.getDocuments().then((value) {
      for (var item in value) {
        final student = Student.fromJson(item);
        students.add(student);
      }
      return students;
    });
    return students;
  }
}

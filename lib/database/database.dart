import 'package:mongo_dart/mongo_dart.dart';
import 'package:rxdart/subjects.dart';

import 'package:ecs_attendance/models/login.dart';
import 'package:ecs_attendance/models/register.dart';
import 'package:ecs_attendance/models/student.dart';
import 'package:ecs_attendance/utils/constants.dart';
import 'package:ecs_attendance/utils/service.dart';

class MongoDatabase {
  static var db, userCollection;
  final _studentStreamController =
      BehaviorSubject<List<Student>>.seeded(const []);

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }

  Future<List<String>> getStudent() async {
    final loginDetails = await SharedService.loginDetails();
    ObjectId id = ObjectId.parse(loginDetails!.id);
    var u = await userCollection.findOne({"_id": id});
    final student = Student.fromJson(u);
    print(student.name);
    final studentAttendance = student.attendance ?? [];
    return studentAttendance;
  }

  static Future<bool> register(Register student) async {
    final duplicate = await userCollection.findOne({'name': student.name});
    if (duplicate != null) {
      return false;
    } else {
      await userCollection.insertOne(student.toJson());
      return true;
    }
  }

  Stream<List<Student>> getAllStudentsResponse() =>
      _studentStreamController.asBroadcastStream();

  static Future<bool> login(Login login) async {
    final student =
        await userCollection.findOne({'name': login.name, 'pass': login.pass});
    if (student != null) {
      final response = Register.fromJson(student);
      await SharedService.setLoginDetails(response);
      return true;
    } else {
      return false;
    }
  }

  static update(String date) async {
    final loginDetails = await SharedService.loginDetails();
    ObjectId id = ObjectId.parse(loginDetails!.id);
    var u = await userCollection.findOne({"_id": id});
    List<dynamic> list = u["attendance"] ?? [];
    list.add(date);
    u["attendance"] = list;
    await userCollection.save(u);
  }

  static delete(Student user) async {
    await userCollection.remove(where.id(user.id));
  }
}

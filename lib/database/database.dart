import 'package:ecs_attendance/models/login.dart';
import 'package:ecs_attendance/models/student.dart';
import 'package:ecs_attendance/utils/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
    print(userCollection);
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    final students = await userCollection.find().toList();
    return students;
  }

  static register(Student user) async {
    await userCollection.insertOne([user.toJson()]);
  }

  static login(Login login) async {
    var student = await userCollection.findOne({"name": login.name}, {"pass": login.pass});
  }

  static update(Student user, String date) async {
    var u = await userCollection.findOne({"name": "Niraj"});
    List<dynamic> list = u["attendance"];
    list.add(date);
    u["attendance"] = list;
    await userCollection.save(u);
  }
/*
  static delete(User user) async {
    await userCollection.remove(where.id(user.id));
  } */
}

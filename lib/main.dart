import 'package:ecs_attendance/database/database.dart';
import 'package:ecs_attendance/pages/home/home_page.dart';
import 'package:ecs_attendance/pages/login/login_page.dart';
import 'package:ecs_attendance/pages/register/register_page.dart';
import 'package:ecs_attendance/utils/service.dart';
import 'package:flutter/material.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/home": (context) => const HomePage(),
        "/": (context) => _defaultHome,
      },
    );
  }
}

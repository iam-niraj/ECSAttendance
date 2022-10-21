import 'package:ecs_attendance/database/database.dart';
import 'package:ecs_attendance/pages/home_page.dart';
import 'package:ecs_attendance/pages/qr_page.dart';
import 'package:ecs_attendance/pages/qrscane.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

/*   bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  } */
  _getCameraPermission();
  runApp(MyApp());
}

Future<PermissionStatus> _getCameraPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    final result = await Permission.camera.request();
    return result;
  } else {
    return status;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/qrscan": (context) => ScanScreen(),
        "/qrpage": (context) => QRPage(),
        "/home": (context) => const HomePage(),
        "/": (context) => const HomePage(),
      },
      // ),
    );
  }
}

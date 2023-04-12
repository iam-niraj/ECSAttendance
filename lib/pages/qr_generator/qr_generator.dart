import 'package:ecs_attendance/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorPage extends StatefulWidget {
  QRGeneratorPage({Key? key}) : super(key: key);

  @override
  State<QRGeneratorPage> createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  final qrKey = GlobalKey();
  var id = "";

  @override
  void initState() {
    super.initState();
  }

  Future<String> getId() async {
    final stdid = await SharedService.loginDetails();
    id = stdid!.id;
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getId(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return RepaintBoundary(
          key: qrKey,
          child: QrImage(
            data: snapshot.data!,
            size: 250,
            backgroundColor: Colors.white,
            version: QrVersions.auto,
          ),
        );
      },
    );
  }
}

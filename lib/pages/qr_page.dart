import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  QRPage({Key? key}) : super(key: key);

  final qrKey = GlobalKey();
  String qrData = 'Our Qr Data';
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RepaintBoundary(
            key: qrKey,
            child: QrImage(
              data: DateTime(now.year, now.month, now.day).toString(), //This is the part we give data to our QR
              //  embeddedImage: , You can add your custom image to the center of your QR
              //  semanticsLabel:'', You can add some info to display when your QR scanned
              size: 250,
              backgroundColor: Colors.white,
              version: QrVersions.auto, //You can also give other versions
            ),
          ),
        ),
      ),
    );
  }
}

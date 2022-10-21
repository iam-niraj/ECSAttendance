import 'package:ecs_attendance/widgets/button.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/qrpage"),
            child: const MyButton(
              text: 'Admin',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/qrscan"),
            child: const MyButton(
              text: 'Student',
            ),
          )
        ],
      ),
    )));
  }
}
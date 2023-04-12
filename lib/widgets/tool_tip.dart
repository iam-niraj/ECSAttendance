import 'package:flutter/material.dart';

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final Function()? onTap;

   const MyTooltip({Key? key, required this.message, required this.child, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        triggerMode: TooltipTriggerMode.longPress,
        message: message,
        child: child,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AppButtonFreetext extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onLongPressed;
  final String text;
  final Color? backgroundColor;
  final double fontSize;

  const AppButtonFreetext({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.text,
    this.backgroundColor,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 60),
        maximumSize: const Size(double.infinity, 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }
}

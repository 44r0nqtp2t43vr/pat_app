import 'package:flutter/material.dart';

class AppButtonFreetext extends StatelessWidget {
  final Function() onPressed;
  final Function()? onLongPressed;
  final String text;
  final Color? backgroundColor;

  const AppButtonFreetext({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.text,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 60),
        maximumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: FittedBox(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}

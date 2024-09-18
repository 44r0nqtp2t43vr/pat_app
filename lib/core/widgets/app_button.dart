import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final Function()? onLongPressed;
  final TextMeaning textMeaning;
  final double fontSize;

  const AppButton({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.textMeaning,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        maximumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: GetBuilder<LanguageController>(
        builder: (controller) {
          return Text(
            controller.translate(textMeaning),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}

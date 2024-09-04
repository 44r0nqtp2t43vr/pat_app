import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppBigButton extends StatelessWidget {
  final Function() onPressed;
  final Function()? onLongPressed;
  final TextMeaning textMeaning;

  const AppBigButton({super.key, required this.onPressed, this.onLongPressed, required this.textMeaning});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 120),
        maximumSize: const Size(double.infinity, 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: GetBuilder<LanguageController>(
        builder: (controller) {
          return Text(
            controller.translate(textMeaning),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}

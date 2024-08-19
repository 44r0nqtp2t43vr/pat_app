import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppTitleText extends StatelessWidget {
  final TextMeaning title;

  const AppTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) {
        return Text(
          controller.translate(title),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

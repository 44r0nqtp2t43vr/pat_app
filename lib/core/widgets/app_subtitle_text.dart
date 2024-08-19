import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppSubtitleText extends StatelessWidget {
  final TextMeaning subtitle;

  const AppSubtitleText({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) {
        return Text(
          controller.translate(subtitle),
          style: const TextStyle(
            fontSize: 32,
          ),
        );
      },
    );
  }
}

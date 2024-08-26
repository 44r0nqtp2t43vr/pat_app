import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppSubtitleText extends StatelessWidget {
  final TextMeaning subtitle;
  final double fontSize;

  const AppSubtitleText({super.key, required this.subtitle, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) {
        return Text(
          controller.translate(subtitle),
          style: TextStyle(
            fontSize: fontSize,
          ),
        );
      },
    );
  }
}

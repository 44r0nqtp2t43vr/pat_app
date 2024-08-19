import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppLabelledText extends StatelessWidget {
  final TextMeaning label;
  final String value;
  final int labelFlex;
  final int valueFlex;

  const AppLabelledText({
    super.key,
    required this.label,
    required this.value,
    this.labelFlex = 4,
    this.valueFlex = 6,
  });

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20;

    return GetBuilder<LanguageController>(
      builder: (controller) {
        return Row(
          children: [
            Expanded(
              flex: controller.getCurrentLanguage() == Language.english ? labelFlex : labelFlex ~/ 2,
              child: Text(
                "${controller.translate(label)}:",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              flex: valueFlex,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

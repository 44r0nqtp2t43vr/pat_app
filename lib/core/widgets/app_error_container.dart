import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';

class AppErrorContainer extends StatelessWidget {
  final TextMeaning errorTextMeaning;
  final TextMeaning buttonTextMeaning;
  final Function(BuildContext)? onPop;

  const AppErrorContainer({
    super.key,
    required this.errorTextMeaning,
    required this.buttonTextMeaning,
    this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GetBuilder<LanguageController>(
          builder: (controller) {
            return Text(
              controller.translate(errorTextMeaning),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        AppButton(
          onPressed: onPop == null ? () => Navigator.of(context).pop() : () => onPop!(context),
          textMeaning: buttonTextMeaning,
        ),
      ],
    );
  }
}

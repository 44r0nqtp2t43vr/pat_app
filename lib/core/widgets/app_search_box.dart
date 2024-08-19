import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

class AppSearchBox extends StatelessWidget {
  final TextMeaning labelText;
  final TextMeaning? hintText;
  final TextEditingController textController;

  const AppSearchBox({
    super.key,
    required this.labelText,
    this.hintText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.translate(labelText),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: textController,
              style: const TextStyle(
                fontSize: 32,
              ),
              decoration: InputDecoration(
                hintText: hintText == null ? null : controller.translate(hintText!),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0XFFd1d1d1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0XFF275492), width: 2),
                ),
                contentPadding: const EdgeInsets.all(16.0),
              ),
            ),
          ],
        );
      },
    );
  }
}

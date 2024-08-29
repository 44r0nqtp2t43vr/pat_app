import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

enum DataType { string, double, integer }

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final TextMeaning mainLabel;
  final TextMeaning? hintText;
  final String? subLabel;
  final DataType dataType;
  final bool required;
  final bool? enabled;
  final String? Function()? specialValidator;
  final int? maxLines;

  const AppTextField({
    super.key,
    required this.controller,
    this.errorText,
    required this.mainLabel,
    this.hintText,
    this.subLabel,
    this.dataType = DataType.string,
    this.required = false,
    this.specialValidator,
    this.enabled,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    const double fontSize = 28;
    const double hintFontSize = 20;

    return Column(
      children: [
        Row(
          mainAxisAlignment: subLabel != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
          children: [
            GetBuilder<LanguageController>(
              builder: (controller) {
                return Expanded(
                  child: Text(
                    controller.translate(mainLabel),
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                );
              },
            ),
            subLabel != null
                ? Text(
                    subLabel!,
                    style: const TextStyle(
                      fontSize: fontSize,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 12.0),
        GetBuilder<LanguageController>(
          builder: (languageController) {
            return TextFormField(
              controller: controller,
              maxLines: maxLines,
              readOnly: enabled == null || enabled == true ? false : true,
              keyboardType: dataType != DataType.integer ? null : const TextInputType.numberWithOptions(),
              inputFormatters: dataType != DataType.integer ? null : [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                hintText: hintText == null ? null : languageController.translate(hintText!),
                hintStyle: const TextStyle(fontSize: hintFontSize),
                hintMaxLines: 2,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFd1d1d1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFF275492), width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: fontSize,
                ),
                contentPadding: const EdgeInsets.all(16.0),
              ),
              validator: (value) {
                if (dataType == DataType.string) {
                  if (required && (value == null || value.trim().isEmpty)) {
                    return errorText;
                  }
                } else if (dataType == DataType.double) {
                  if ((required && (value == null || value.trim().isEmpty)) || (value != null && value.trim().isNotEmpty && double.tryParse(value.trim()) == null)) {
                    return errorText;
                  }
                }

                if (specialValidator != null) {
                  return specialValidator!();
                } else {
                  return null;
                }
              },
            );
          },
        ),
      ],
    );
  }
}

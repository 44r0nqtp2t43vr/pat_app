import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_title_text.dart';

class WorkIdPhotoPreview extends StatelessWidget {
  final String imagePath;

  const WorkIdPhotoPreview({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 40.0,
            bottom: 40.0,
          ),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: AppTitleText(
                  title: TextMeaning.workIDPhoto,
                ),
              ),
              Expanded(
                child: Image.file(
                  File(imagePath),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(
                onPressed: () => _onWorkIdButtonPressed(context),
                textMeaning: TextMeaning.retakePhoto,
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(
                onPressed: () => _onConfirmButtonPressed(context),
                textMeaning: TextMeaning.confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onWorkIdButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/workId');
  }

  void _onConfirmButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/confirmSave');
  }
}

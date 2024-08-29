import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_big_button.dart';
import 'package:pat_app/core/widgets/app_subtitle_text.dart';
import 'package:pat_app/core/widgets/app_title_text.dart';

class DeliveryDriver extends StatelessWidget {
  const DeliveryDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 80.0,
            bottom: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: AppTitleText(
                  title: TextMeaning.deliveryDriver,
                ),
              ),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppSubtitleText(
                  subtitle: TextMeaning.chooseOneFromTheOptionsBelow,
                ),
              ),
              const SizedBox(height: 40),
              AppBigButton(
                onPressed: () => _onESignatureButtonPressed(context),
                textMeaning: TextMeaning.electronicSignature,
              ),
              const SizedBox(height: 20),
              AppBigButton(
                onPressed: () => _onWorkIdButtonPressed(context),
                textMeaning: TextMeaning.workIDPhoto,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onESignatureButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/electronicSignature');
  }

  void _onWorkIdButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/workId');
  }
}

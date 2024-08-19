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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 40.0,
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
            const Align(
              alignment: Alignment.centerLeft,
              child: AppSubtitleText(
                subtitle: TextMeaning.chooseOneFromTheOptionsBelow,
              ),
            ),
            AppBigButton(
              onPressed: () {},
              textMeaning: TextMeaning.electronicSignature,
            ),
            AppBigButton(
              onPressed: () {},
              textMeaning: TextMeaning.workIDPhoto,
            ),
          ],
        ),
      ),
    );
  }
}

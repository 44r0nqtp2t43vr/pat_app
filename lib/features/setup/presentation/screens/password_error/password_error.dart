import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_error_container.dart';

class PasswordError extends StatelessWidget {
  const PasswordError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 40.0,
        ),
        child: AppErrorContainer(
          errorTextMeaning: TextMeaning.passwordError,
          buttonTextMeaning: TextMeaning.confirm,
        ),
      ),
    );
  }
}

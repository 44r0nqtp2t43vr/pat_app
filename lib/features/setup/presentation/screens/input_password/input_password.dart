import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_text_field.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({super.key});

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate() && _passwordController.text == "Pat168Q_Q") {
      Navigator.pushNamed(context, '/inputSetup');
    } else {
      Navigator.pushNamed(context, '/passwordError');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppTextField(
                controller: _passwordController,
                mainLabel: TextMeaning.password,
              ),
              AppButton(
                onPressed: () => _login(context),
                textMeaning: TextMeaning.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

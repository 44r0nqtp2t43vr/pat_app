import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/setup_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_text_field.dart';
import 'package:pat_app/injection_container.dart';

class InputSetup extends StatefulWidget {
  const InputSetup({super.key});

  @override
  State<InputSetup> createState() => _InputSetupState();
}

class _InputSetupState extends State<InputSetup> {
  final _formKey = GlobalKey<FormState>();
  final _serverIPController = TextEditingController();
  final _timeoutSettingController = TextEditingController();

  @override
  void initState() {
    _serverIPController.text = sl<SetupController>().getServerIP();
    _timeoutSettingController.text = sl<SetupController>().getTimeoutSec().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          sl<LanguageController>().translate(TextMeaning.setup),
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                  bottom: 40.0,
                ),
                child: Column(
                  children: [
                    AppTextField(
                      controller: _serverIPController,
                      mainLabel: TextMeaning.serverIP,
                    ),
                    const SizedBox(height: 40),
                    AppTextField(
                      controller: _timeoutSettingController,
                      mainLabel: TextMeaning.timeoutSetting,
                      dataType: DataType.integer,
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      onPressed: () => _onStorageButtonPressed(context),
                      textMeaning: TextMeaning.storage,
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      onPressed: () {},
                      textMeaning: TextMeaning.manualSyn,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onStorageButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      sl<SetupController>().setServerIP(_serverIPController.text.trim());
      sl<SetupController>().setTimeoutSec(int.parse(_timeoutSettingController.text.trim()));
      Navigator.pushNamed(context, "/");
    }
  }
}

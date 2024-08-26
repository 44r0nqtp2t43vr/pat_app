import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/injection_container.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isEntryIndexNull = sl<SelectedRCsListController>().isEntryIndexNull();

    return PopScope(
      canPop: isEntryIndexNull ? false : true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }

        if (isEntryIndexNull) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _onLanguageButtonPressed(),
                  child: const Text(
                    "中/EN",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              AppButton(
                onPressed: () => _onUserLoginButtonPressed(context),
                textMeaning: TextMeaning.userLogin,
              ),
              AppButton(
                onPressed: () => _onExitButtonPressed(context),
                textMeaning: TextMeaning.exit,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => _onSetupButtonPressed(context),
                  child: const Icon(
                    Icons.settings,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLanguageButtonPressed() {
    sl<LanguageController>().toggleCurrentLanguage();
  }

  void _onUserLoginButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/userLogin');
  }

  void _onExitButtonPressed(BuildContext context) {
    SystemNavigator.pop();
  }

  void _onSetupButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/inputPassword');
  }
}

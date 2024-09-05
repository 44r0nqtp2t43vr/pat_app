import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_text_field.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_event.dart';
import 'package:pat_app/injection_container.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final _employeeIDController = TextEditingController();

  void _loginUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      sl<SelectedRCsListController>().setSelectedRCsList([]);
      BlocProvider.of<EmployeeBloc>(context).add(CheckUserInformationEvent(_employeeIDController.text));
      Navigator.pushNamed(context, '/selectVia');
    }
  }

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
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                AppTextField(
                  controller: _employeeIDController,
                  mainLabel: TextMeaning.employeeID,
                ),
                AppButton(
                  onPressed: () => _loginUser(context),
                  textMeaning: TextMeaning.login,
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
      ),
    );
  }

  void _onLanguageButtonPressed() {
    sl<LanguageController>().toggleCurrentLanguage();
  }

  void _onSetupButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/inputPassword');
  }
}

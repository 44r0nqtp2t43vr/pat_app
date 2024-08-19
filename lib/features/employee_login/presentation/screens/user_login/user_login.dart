import 'package:flutter/material.dart';
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
      BlocProvider.of<EmployeeBloc>(context).add(LoginEmployeeEvent(_employeeIDController.text));
      Navigator.pushNamed(context, '/selectEntries');
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
                controller: _employeeIDController,
                mainLabel: TextMeaning.employeeID,
              ),
              AppButton(
                onPressed: () => _loginUser(context),
                textMeaning: TextMeaning.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_error_container.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_state.dart';

class SelectEntries extends StatefulWidget {
  const SelectEntries({super.key});

  @override
  State<SelectEntries> createState() => _SelectEntriesState();
}

class _SelectEntriesState extends State<SelectEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeDone) {
              return Container();
            }
            if (state is EmployeeError) {
              return const AppErrorContainer(
                errorTextMeaning: TextMeaning.passwordError,
                buttonTextMeaning: TextMeaning.password,
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}

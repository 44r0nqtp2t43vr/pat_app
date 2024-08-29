import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_error_container.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_state.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_state.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_state.dart';

class NetworkError extends StatelessWidget {
  final dynamic state;

  const NetworkError({super.key, required this.state});

  dynamic getCallbackByState(BuildContext context) {
    if (state is EmployeeError) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else if (state is RCsListError) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else if (state is ShippedResultError) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }

        getCallbackByState(context);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 40.0,
          ),
          child: AppErrorContainer(
            errorTextMeaning: TextMeaning.networkConnectionError,
            buttonTextMeaning: TextMeaning.backForCheck,
            onPop: (context) => getCallbackByState(context),
          ),
        ),
      ),
    );
  }
}

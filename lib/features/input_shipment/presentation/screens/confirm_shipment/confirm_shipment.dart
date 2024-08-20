import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_big_button.dart';
import 'package:pat_app/core/widgets/app_labelled_text.dart';
import 'package:pat_app/core/widgets/app_timer.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_bloc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_event.dart';
import 'package:pat_app/injection_container.dart';

class ConfirmShipment extends StatelessWidget {
  const ConfirmShipment({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = BlocProvider.of<EmployeeBloc>(context).state.employee!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 40.0,
          bottom: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AppLabelledText(
                  label: TextMeaning.employeeID,
                  value: employee.id,
                ),
                AppLabelledText(
                  label: TextMeaning.name,
                  value: employee.name,
                ),
              ],
            ),
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: AppTimer(),
                ),
                const SizedBox(height: 20),
                AppBigButton(
                  onPressed: () {},
                  textMeaning: TextMeaning.toCheckShipmentDetails,
                ),
                const SizedBox(height: 20),
                AppBigButton(
                  onPressed: () => _onCancelButtonPressed(context),
                  textMeaning: TextMeaning.cancelThisShipment,
                ),
                const SizedBox(height: 20),
                AppBigButton(
                  onPressed: () => _onProceedButtonPressed(context),
                  textMeaning: TextMeaning.proceedWithShipment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onCancelButtonPressed(BuildContext context) {
    sl<SelectedRCsListController>().setSelectedRCsList([]);
    BlocProvider.of<RCsListBloc>(context).add(const GetRCsListEvent());
    Navigator.pushNamed(context, '/selectEntries');
  }

  void _onProceedButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/deliveryDriver');
  }
}

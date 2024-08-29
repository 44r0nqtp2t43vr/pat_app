// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/files_controller.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_title_text.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_bloc.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_event.dart';
import 'package:pat_app/injection_container.dart';

class WorkIdPhotoPreview extends StatelessWidget {
  final XFile image;

  const WorkIdPhotoPreview({Key? key, required this.image}) : super(key: key);

  // void _onConfirm(BuildContext context) {
  //   final employee = BlocProvider.of<EmployeeBloc>(context).state.employee!;
  //   sl<FilesController>().saveImageToDirectory(image, employee.id);
  //   Navigator.pushNamed(context, '/confirmSave');
  // }

  void _onConfirm(BuildContext context) async {
    if (await File(image.path).exists()) {
      final imageBytes = await File(image.path).readAsBytes();
      if (imageBytes.isNotEmpty) {
        sl<FilesController>().setWorkIdPhoto(imageBytes);

        if (sl<FilesController>().isElectronicSignatureSubmitted) {
          final employee = BlocProvider.of<EmployeeBloc>(context).state.employee;
          final shippedItems = sl<SelectedRCsListController>().getSelectedRCsList();

          final employeeID = employee!.id;
          final shippedItemsString = shippedItems.map((item) => item.shippedItem).toList().join(',');

          BlocProvider.of<ShippedResultBloc>(context).add(GetShippedResultEvent(getShippedResultData: "$employeeID\n$shippedItemsString"));
          Navigator.pushReplacementNamed(context, '/confirmSave');
        } else {
          Navigator.of(context).pop();
        }
      } else {
        print('Error: Image file is empty');
      }
    } else {
      print('Error: Image file does not exist');
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

        Navigator.pushReplacementNamed(context, '/workId');
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 40.0,
              bottom: 40.0,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: AppTitleText(
                    title: TextMeaning.workIDPhoto,
                  ),
                ),
                Expanded(
                  child: Image.file(
                    File(image.path),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  onPressed: () => _onWorkIdButtonPressed(context),
                  textMeaning: TextMeaning.retakePhoto,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  onPressed: () => _onConfirm(context),
                  textMeaning: TextMeaning.confirm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onWorkIdButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/workId');
  }
}

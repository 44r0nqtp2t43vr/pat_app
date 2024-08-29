// ignore_for_file: use_build_context_synchronously

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
import 'package:signature/signature.dart';
import 'package:flutter/services.dart';

class ElectronicSignature extends StatefulWidget {
  const ElectronicSignature({super.key});

  @override
  State<ElectronicSignature> createState() => _ElectronicSignatureState();
}

class _ElectronicSignatureState extends State<ElectronicSignature> {
  final SignatureController _signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 3.0,
    exportBackgroundColor: Colors.white,
  );

  void _clearSignature() {
    _signatureController.clear();
  }

  // Future<void> _saveSignature() async {
  //   if (_signatureController.isNotEmpty) {
  //     final Uint8List? image = await _signatureController.toPngBytes();

  //     if (image != null) {
  //       final status = await Permission.storage.request();
  //       if (status.isGranted) {
  //         final directory = await getApplicationDocumentsDirectory();
  //         final String path = '${directory.path}/signature.png';
  //         final File file = File(path);
  //         await file.writeAsBytes(image);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Signature saved at $path')),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Permission denied')),
  //         );
  //       }
  //     }
  //   }
  // }

  void _onConfirm(BuildContext context) async {
    if (_signatureController.isNotEmpty) {
      final image = await _signatureController.toPngBytes();
      if (image != null) {
        sl<FilesController>().setElectronicSignature(image);

        if (sl<FilesController>().isWorkIdPhotoSubmitted) {
          final employee = BlocProvider.of<EmployeeBloc>(context).state.employee;
          final shippedItems = sl<SelectedRCsListController>().getSelectedRCsList();

          final employeeID = employee!.id;
          final shippedItemsString = shippedItems.map((item) => item.shippedItem).toList().join(',');

          BlocProvider.of<ShippedResultBloc>(context).add(GetShippedResultEvent(getShippedResultData: "$employeeID\n$shippedItemsString"));
          Navigator.pushReplacementNamed(context, '/confirmSave');
        } else {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _signatureController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: AppTitleText(
                title: TextMeaning.electronicSignature,
              ),
            ),
            Expanded(
              child: Signature(
                controller: _signatureController,
                backgroundColor: const Color.fromARGB(255, 232, 232, 232),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: _clearSignature,
                    textMeaning: TextMeaning.clear,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AppButton(
                    onPressed: () => _onConfirm(context),
                    textMeaning: TextMeaning.confirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

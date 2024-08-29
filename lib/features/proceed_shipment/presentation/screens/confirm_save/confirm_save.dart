import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/files_controller.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_big_button.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_bloc.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_state.dart';
import 'package:pat_app/injection_container.dart';

class ConfirmSave extends StatelessWidget {
  const ConfirmSave({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShippedResultBloc, ShippedResultState>(
      listener: (context, state) {
        if (state is ShippedResultError) {
          if (state.exception is SocketException || state.exception is TimeoutException) {
            Navigator.pushNamed(context, '/networkError', arguments: state);
          } else {
            Navigator.pushNamed(context, '/postError');
          }
        }
      },
      builder: (context, state) {
        if (state is ShippedResultDone) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, Object? result) {
              if (didPop) {
                return;
              }

              _onExitButtonPressed(context);
            },
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 40.0,
                  bottom: 40.0,
                ),
                child: Center(
                  child: AppBigButton(
                    onPressed: () => _onExitButtonPressed(context),
                    textMeaning: TextMeaning.exit,
                  ),
                ),
              ),
            ),
          );
        } else if (state is ShippedResultError) {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        return const PopScope(
          canPop: false,
          child: Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );
  }

  void _onExitButtonPressed(BuildContext context) {
    sl<FilesController>().resetStates();
    sl<SelectedRCsListController>().setSelectedRCsList([]);

    Navigator.pushNamed(context, '/selectVia');
  }
}

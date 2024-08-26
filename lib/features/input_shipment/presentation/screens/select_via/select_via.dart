import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_button_freetext.dart';
import 'package:pat_app/core/widgets/app_subtitle_text.dart';
// import 'package:pat_app/core/widgets/app_search_box.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_state.dart';
import 'package:pat_app/features/input_shipment/domain/models/get_rcs_list_data.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_bloc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_event.dart';
import 'package:pat_app/injection_container.dart';

class SelectVia extends StatefulWidget {
  const SelectVia({super.key});

  @override
  State<SelectVia> createState() => _SelectViaState();
}

class _SelectViaState extends State<SelectVia> {
  String? _selectedCustomer;
  // final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _rcnoController = TextEditingController();

  void _autoDeselectCustomer() {
    if (_selectedCustomer != null) {
      setState(() {
        _selectedCustomer = null;
      });
    }
  }

  void _selectOrDeselectCustomer(String customer) {
    if (_selectedCustomer == null || _selectedCustomer != customer) {
      setState(() {
        _selectedCustomer = customer;
        _rcnoController.text = "";
      });
    } else {
      setState(() {
        _selectedCustomer = null;
      });
    }
  }

  void _confirmSelected(BuildContext context) {
    if (_rcnoController.text.trim().isNotEmpty && _formKey.currentState!.validate()) {
      // get rcs list
      BlocProvider.of<RCsListBloc>(context).add(GetRCsListEvent(getRCsListData: GetRCsListData(filterString: _rcnoController.text.trim())));
      Navigator.pushNamed(context, '/selectEntries');
    } else if (_selectedCustomer != null) {
      // get rcs list
      BlocProvider.of<RCsListBloc>(context).add(GetRCsListEvent(getRCsListData: GetRCsListData(isTextInput: false, filterString: _selectedCustomer!)));
      Navigator.pushNamed(context, '/selectEntries');
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
          Navigator.pushReplacementNamed(context, '/userLogin');
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: 40.0,
            ),
            child: BlocConsumer<EmployeeBloc, EmployeeState>(
              listener: (context, state) {
                if (state is EmployeeError) {
                  if (state.exception is SocketException || state.exception is TimeoutException) {
                    Navigator.pushNamed(context, '/networkError', arguments: state);
                  } else {
                    Navigator.pushNamed(context, '/employeeIDError');
                  }
                }
              },
              builder: (context, state) {
                if (state is EmployeeDone) {
                  const customers = ["(015)創惟", "(214)聯詠"];

                  return Column(
                    children: [
                      // AppSearchBox(
                      //   labelText: TextMeaning.rcNo,
                      //   textController: _searchController,
                      // ),
                      // const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: AppSubtitleText(
                          subtitle: TextMeaning.viaShippingNo,
                          fontSize: 28,
                        ),
                      ),
                      TextField(
                        controller: _rcnoController,
                        onChanged: (value) => _autoDeselectCustomer(),
                        style: const TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: AppSubtitleText(
                          subtitle: TextMeaning.viaCustomer,
                          fontSize: 28,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: customers.length,
                          itemBuilder: (context, index) {
                            final customer = customers[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: AppButtonFreetext(
                                onPressed: () => _selectOrDeselectCustomer(customer),
                                text: customer,
                                backgroundColor: _selectedCustomer != null && _selectedCustomer == customer ? Colors.blue[200] : null,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        onPressed: () => _confirmSelected(context),
                        textMeaning: TextMeaning.confirm,
                      ),
                    ],
                  );
                }
                // if (state is EmployeeError) {
                //   return const AppErrorContainer(
                //     errorTextMeaning: TextMeaning.dataError,
                //     buttonTextMeaning: TextMeaning.backForCheck,
                //   );
                // }
                return const Center(child: CupertinoActivityIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

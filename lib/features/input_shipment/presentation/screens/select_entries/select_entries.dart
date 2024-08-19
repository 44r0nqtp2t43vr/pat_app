import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_button_freetext.dart';
import 'package:pat_app/core/widgets/app_error_container.dart';
import 'package:pat_app/core/widgets/app_search_box.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_state.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_bloc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_event.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_state.dart';
import 'package:pat_app/injection_container.dart';

class SelectEntries extends StatefulWidget {
  const SelectEntries({super.key});

  @override
  State<SelectEntries> createState() => _SelectEntriesState();
}

class _SelectEntriesState extends State<SelectEntries> {
  late List<RC> _selectedRCsList;
  final TextEditingController _searchController = TextEditingController();

  void _selectOrDeselectRC(RC rc) {
    final index = _selectedRCsList.indexWhere((selectedRC) => selectedRC.rcno == rc.rcno);
    if (index >= 0) {
      setState(() {
        _selectedRCsList.removeAt(index);
      });
    } else {
      setState(() {
        _selectedRCsList.add(rc);
      });
    }
  }

  void _confirmSelected(BuildContext context) {
    if (_selectedRCsList.isNotEmpty) {
      sl<SelectedRCsListController>().setSelectedRCsList(_selectedRCsList);
      Navigator.pushNamed(context, '/processEntries', arguments: 0);
    }
  }

  @override
  void initState() {
    _selectedRCsList = sl<SelectedRCsListController>().getSelectedRCsList();
    _searchController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 40.0,
        ),
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeDone) {
              BlocProvider.of<RCsListBloc>(context).add(const GetRCsListEvent());
            }
          },
          builder: (context, state) {
            if (state is EmployeeDone) {
              return Column(
                children: [
                  AppSearchBox(
                    labelText: TextMeaning.rcNo,
                    textController: _searchController,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: BlocBuilder<RCsListBloc, RCsListState>(
                      builder: (context, state) {
                        if (state is RCsListDone) {
                          final filteredRCsList = state.rcsList!.where((rc) => rc.rcno.contains(_searchController.text)).toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: filteredRCsList.length,
                            itemBuilder: (context, index) {
                              final rc = filteredRCsList[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: AppButtonFreetext(
                                  onPressed: () => _selectOrDeselectRC(rc),
                                  text: rc.rcno,
                                  backgroundColor: _selectedRCsList.indexWhere((selectedRC) => selectedRC.rcno == rc.rcno) >= 0 ? Colors.blue[200] : null,
                                ),
                              );
                            },
                          );
                        }
                        if (state is RCsListError) {
                          return const Center(child: CupertinoActivityIndicator());
                        }
                        return const Center(child: CupertinoActivityIndicator());
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

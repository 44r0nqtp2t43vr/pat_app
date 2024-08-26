import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_button_freetext.dart';
import 'package:pat_app/core/widgets/app_title_text.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_bloc.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_state.dart';
import 'package:pat_app/injection_container.dart';

class SelectEntries extends StatefulWidget {
  const SelectEntries({super.key});

  @override
  State<SelectEntries> createState() => _SelectEntriesState();
}

class _SelectEntriesState extends State<SelectEntries> {
  late List<RC> _selectedRCsList;

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
      Navigator.pushNamed(context, '/processEntries');
    }
  }

  @override
  void initState() {
    _selectedRCsList = sl<SelectedRCsListController>().getSelectedRCsList();
    // _searchController.addListener(() => setState(() {}));
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
        child: BlocConsumer<RCsListBloc, RCsListState>(
          listener: (context, state) {
            if (state is RCsListError) {
              Navigator.pushNamed(context, '/networkError', arguments: state);
            }
          },
          builder: (context, state) {
            if (state is RCsListDone) {
              // final filteredRCsList = state.rcsList!.where((rc) => rc.rcno.contains(_searchController.text)).toList();
              final filteredRCsList = state.rcsList!;

              return Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppTitleText(
                      title: TextMeaning.shippedItems,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
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
            if (state is RCsListError) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_text_field.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/injection_container.dart';

class ProcessEntries extends StatefulWidget {
  final int entryIndex;

  const ProcessEntries({super.key, required this.entryIndex});

  @override
  State<ProcessEntries> createState() => _ProcessEntriesState();
}

class _ProcessEntriesState extends State<ProcessEntries> {
  late RC entry;
  bool isFirstPage = true;

  final _formKey = GlobalKey<FormState>();
  final _rcnoController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _productPartNumberController = TextEditingController();
  final _totalNumberOfShipmentBoxesController = TextEditingController();
  final _quantityOfProductsInTheLastShipmentBox = TextEditingController();

  void _submitData(BuildContext context) {
    if (isFirstPage) {
      setState(() {
        isFirstPage = false;
      });
    } else {
      if (_formKey.currentState!.validate()) {
        // BlocProvider.of<EmployeeBloc>(context).add(LoginEmployeeEvent(_employeeIDController.text));
        // Navigator.pushNamed(context, '/selectEntries');
      }
    }
  }

  @override
  void initState() {
    entry = sl<SelectedRCsListController>().getSelectedRCAtIndex(widget.entryIndex);
    _rcnoController.text = entry.rcno;
    _customerNameController.text = entry.customerName;
    _productPartNumberController.text = entry.productPartNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        if (isFirstPage) {
          Navigator.of(context).pop();
        } else {
          setState(() {
            isFirstPage = true;
          });
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: isFirstPage
                          ? [
                              AppTextField(
                                controller: _rcnoController,
                                mainLabel: TextMeaning.rcNo,
                                enabled: false,
                              ),
                              const SizedBox(height: 40),
                              AppTextField(
                                controller: _customerNameController,
                                mainLabel: TextMeaning.customerName,
                                enabled: false,
                              ),
                              const SizedBox(height: 40),
                              AppTextField(
                                controller: _productPartNumberController,
                                mainLabel: TextMeaning.productPartNumber,
                                enabled: false,
                              ),
                            ]
                          : [
                              AppTextField(
                                controller: _rcnoController,
                                mainLabel: TextMeaning.rcNo,
                                enabled: false,
                              ),
                              const SizedBox(height: 40),
                              AppTextField(
                                controller: _totalNumberOfShipmentBoxesController,
                                mainLabel: TextMeaning.totalNumberOfShipmentBoxes,
                                hintText: TextMeaning.totalNumberOfShipmentBoxesHint,
                                dataType: DataType.integer,
                              ),
                              const SizedBox(height: 40),
                              AppTextField(
                                controller: _quantityOfProductsInTheLastShipmentBox,
                                mainLabel: TextMeaning.quantityOfProductsInTheLastShipmentBox,
                                hintText: TextMeaning.quantityOfProductsInTheLastShipmentBoxHint,
                                dataType: DataType.integer,
                              ),
                            ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  onPressed: () => _submitData(context),
                  textMeaning: TextMeaning.next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

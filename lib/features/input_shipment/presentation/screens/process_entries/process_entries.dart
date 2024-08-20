import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_labelled_text.dart';
import 'package:pat_app/core/widgets/app_text_field.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/injection_container.dart';

class ProcessEntries extends StatefulWidget {
  const ProcessEntries({super.key});

  @override
  State<ProcessEntries> createState() => _ProcessEntriesState();
}

class _ProcessEntriesState extends State<ProcessEntries> {
  late RC entry;
  late int count;
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
        if (_isDataValid()) {
          if (sl<SelectedRCsListController>().isEntryIndexLast()) {
            sl<SelectedRCsListController>().setSelectedRCAtIndex(entry);
            Navigator.pushNamed(context, '/confirmShipment');
          } else {
            sl<SelectedRCsListController>().incrementEntryIndex();
            Navigator.pushNamed(context, '/processEntries');
          }
        } else {
          Navigator.pushNamed(context, '/dataError');
        }
      }
    }
  }

  bool _isDataValid() {
    final numOfProducts = entry.numberOfProducts;
    final numOfProductsInLastShipmentBox = int.tryParse(_quantityOfProductsInTheLastShipmentBox.text.trim());
    final numOfShipmentBoxes = int.tryParse(_totalNumberOfShipmentBoxesController.text.trim());

    if (numOfProductsInLastShipmentBox == null || numOfShipmentBoxes == null || numOfShipmentBoxes == 1) {
      return false;
    }

    final remainder = (numOfProducts - numOfProductsInLastShipmentBox) % (numOfShipmentBoxes - 1);

    if (remainder != 0) {
      return false;
    }

    setState(() {
      entry.numberOfLastShipmentBoxProducts = numOfProductsInLastShipmentBox;
      entry.numberOfShipmentBoxes = numOfShipmentBoxes;
    });

    return true;
  }

  @override
  void initState() {
    entry = sl<SelectedRCsListController>().getSelectedRCAtIndex()!;
    count = sl<SelectedRCsListController>().getSelectedRCsCount();

    _rcnoController.text = entry.rcno;
    _customerNameController.text = entry.customerName;
    _productPartNumberController.text = entry.productPartNumber;
    _totalNumberOfShipmentBoxesController.text = entry.numberOfShipmentBoxes == null ? "" : entry.numberOfShipmentBoxes.toString();
    _quantityOfProductsInTheLastShipmentBox.text = entry.numberOfLastShipmentBoxProducts == null ? "" : entry.numberOfLastShipmentBoxProducts.toString();

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
          sl<SelectedRCsListController>().decrementEntryIndex();
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
                              count > 1
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                                      child: Column(
                                        children: [
                                          AppLabelledText(
                                            label: TextMeaning.numberOfEntriesSelectedInBatch,
                                            value: count.toString(),
                                            englishLabelFlex: 6,
                                            chineseLabelFlex: 6,
                                            valueFlex: 4,
                                          ),
                                          AppLabelledText(
                                            label: TextMeaning.processingEntryNumber,
                                            value: "${sl<SelectedRCsListController>().getEntryIndex()! + 1}",
                                            englishLabelFlex: 6,
                                            chineseLabelFlex: 6,
                                            valueFlex: 4,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
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

import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/widgets/app_big_button.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_text_field.dart';
import 'package:pat_app/injection_container.dart';

class CheckShipment extends StatelessWidget {
  const CheckShipment({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRCsList = sl<SelectedRCsListController>().getSelectedRCsList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 12.0,
          bottom: 40.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: selectedRCsList.length,
                itemBuilder: (context, index) {
                  final rc = selectedRCsList[index];

                  return Column(
                    children: [
                      AppTextField(
                        controller: TextEditingController(text: rc.rcno),
                        mainLabel: TextMeaning.rcNo,
                        enabled: false,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: TextEditingController(text: rc.customerName),
                        mainLabel: TextMeaning.customerName,
                        enabled: false,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: TextEditingController(text: rc.productPartNumber),
                        mainLabel: TextMeaning.productPartNumber,
                        enabled: false,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: TextEditingController(text: rc.numberOfShipmentBoxes.toString()),
                        mainLabel: TextMeaning.totalNumberOfShipmentBoxes,
                        enabled: false,
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        controller: TextEditingController(text: rc.numberOfLastShipmentBoxProducts.toString()),
                        mainLabel: TextMeaning.quantityOfProductsInTheLastShipmentBox,
                        enabled: false,
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              onPressed: () => _onModificationButtonPressed(context),
              textMeaning: TextMeaning.modification,
            ),
            const SizedBox(height: 20),
            AppBigButton(
              onPressed: () => _onProceedButtonPressed(context),
              textMeaning: TextMeaning.proceedWithShipment,
            ),
          ],
        ),
      ),
    );
  }

  void _onModificationButtonPressed(BuildContext context) {
    sl<SelectedRCsListController>().setEntryIndex(0);
    Navigator.pushNamed(context, '/processEntries');
  }

  void _onProceedButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/deliveryDriver');
  }
}

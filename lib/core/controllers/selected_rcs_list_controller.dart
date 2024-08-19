import 'package:get/get.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

class SelectedRCsListController extends GetxController {
  RxList<RC> selectedRCsList = (List<RC>.of([])).obs;

  List<RC> getSelectedRCsList() {
    return List.from(selectedRCsList);
  }

  void setSelectedRCsList(List<RC> newSelectedRCsList) {
    selectedRCsList.assignAll(newSelectedRCsList);
  }

  RC getSelectedRCAtIndex(int index) {
    return selectedRCsList[index];
  }

  void setSelectedRCAtIndex(RC newRC, int index) {
    selectedRCsList[index] = newRC;
  }

  bool isMultipleSelected() {
    return selectedRCsList.length > 1;
  }
}

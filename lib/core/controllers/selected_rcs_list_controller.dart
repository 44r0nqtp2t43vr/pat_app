import 'package:get/get.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

class SelectedRCsListController extends GetxController {
  RxList<RC> selectedRCsList = (List<RC>.of([])).obs;
  Rx<int?> entryIndex = Rx<int?>(null);

  List<RC> getSelectedRCsList() {
    return List.from(selectedRCsList);
  }

  int? getEntryIndex() {
    return entryIndex.value;
  }

  void setSelectedRCsList(List<RC> newSelectedRCsList) {
    selectedRCsList.assignAll(newSelectedRCsList);

    if (newSelectedRCsList.isEmpty) {
      entryIndex.value = null;
    } else {
      entryIndex.value = 0;
    }
  }

  void setEntryIndex(int newEntryIndex) {
    if (newEntryIndex >= 0 || newEntryIndex < getSelectedRCsList().length) {
      entryIndex.value = newEntryIndex;
    }
  }

  RC? getSelectedRCAtIndex() {
    return isEntryIndexNull() ? null : selectedRCsList[entryIndex.value!];
  }

  void setSelectedRCAtIndex(RC newRC) {
    if (!isEntryIndexNull()) {
      selectedRCsList[entryIndex.value!] = newRC;
    }
  }

  bool isMultipleSelected() {
    return selectedRCsList.length > 1;
  }

  bool isEntryIndexNull() {
    return entryIndex.value == null;
  }
}

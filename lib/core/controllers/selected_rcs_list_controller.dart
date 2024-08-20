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

  int getSelectedRCsCount() {
    return selectedRCsList.length;
  }

  void setSelectedRCsList(List<RC> newSelectedRCsList) {
    selectedRCsList.assignAll(newSelectedRCsList);

    if (newSelectedRCsList.isEmpty) {
      entryIndex.value = null;
    } else {
      entryIndex.value = 0;
    }
  }

  void setEntryIndex(int? newEntryIndex) {
    if (newEntryIndex == null || newEntryIndex >= 0 || newEntryIndex < getSelectedRCsList().length) {
      entryIndex.value = newEntryIndex;
    }
  }

  void incrementEntryIndex() {
    if (entryIndex.value != null && entryIndex.value! >= 0 && entryIndex.value! < getSelectedRCsList().length - 1) {
      entryIndex.value = entryIndex.value! + 1;
    }
  }

  void decrementEntryIndex() {
    if (entryIndex.value != null && entryIndex.value! > 0 && entryIndex.value! < getSelectedRCsList().length) {
      entryIndex.value = entryIndex.value! - 1;
    } else if (entryIndex.value != null && entryIndex.value! == 0) {
      entryIndex.value = null;
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

  bool isEntryIndexLast() {
    return entryIndex.value == getSelectedRCsList().length - 1;
  }
}

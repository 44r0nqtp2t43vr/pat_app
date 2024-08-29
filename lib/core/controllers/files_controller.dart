import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const header = [];

class FilesController extends GetxController {
  Rx<Uint8List> electronicSignature = Rx<Uint8List>(Uint8List.fromList([]));
  Rx<Uint8List> workIdPhoto = Rx<Uint8List>(Uint8List.fromList([]));

  bool get isElectronicSignatureSubmitted => electronicSignature.value.isNotEmpty ? true : false;
  bool get isWorkIdPhotoSubmitted => workIdPhoto.value.isNotEmpty ? true : false;

  Uint8List getElectronicSignature() {
    return electronicSignature.value;
  }

  Uint8List getWorkIdPhoto() {
    return workIdPhoto.value;
  }

  void setElectronicSignature(Uint8List newList) {
    electronicSignature.value = newList;
  }

  void setWorkIdPhoto(Uint8List newList) {
    workIdPhoto.value = newList;
  }

  void resetStates() {
    setElectronicSignature(Uint8List.fromList([]));
    setWorkIdPhoto(Uint8List.fromList([]));
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<String?> getExternalSdCardPath() async {
    if (await _requestPermission(Permission.storage)) {
      List<Directory>? extDirectories = await getExternalStorageDirectories();
      if (extDirectories == null) {
        return null;
      } else if (extDirectories.length == 1) {
        return extDirectories[0].path;
      }
      return extDirectories[1].path;
    }
    return null;
  }

  Future<void> saveImageToDirectory(Uint8List image, String folderName, String fileName) async {
    final directoryPath = await getExternalSdCardPath();

    if (directoryPath == null) {
      return;
    }

    final dir = Directory('$directoryPath/$folderName');
    final File file = File('$directoryPath/$folderName/$fileName');

    try {
      if (await dir.exists()) {
        await file.writeAsBytes(image);
      } else {
        await dir.create();
        await file.writeAsBytes(image);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> saveTextToFile(String text, String folderName, String fileName) async {
    final directoryPath = await getExternalSdCardPath();

    if (directoryPath == null) {
      return;
    }

    final dir = Directory('$directoryPath/$folderName');
    final File file = File('$directoryPath/$folderName/$fileName');

    try {
      if (await dir.exists()) {
        await file.writeAsString(text);
      } else {
        await dir.create(recursive: true);
        await file.writeAsString(text);
      }
    } catch (e) {
      return;
    }
  }

  // Future<void> writeCsvToDirectory(dynamic data, {String? oldRcno}) async {
  //   // final today = DateTime.now();
  //   final oldDate = data.date;
  //   // data.date = dateTimeToString(today);

  //   final directoryPath = await getExternalSdCardPath();
  //   if (directoryPath == null) {
  //     return;
  //   }

  //   // final file = File('$directoryPath/${dateTimeToFilename(today)}.csv');
  //   final file = File('$directoryPath/test.csv');
  //   try {
  //     if (oldRcno != null) {
  //       if (stringToFilename(oldDate!) == stringToFilename(data.date!)) {
  //         // if same month as old row, simply edit the row
  //         final csvData = await file.readAsString();
  //         List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
  //         final indexToEdit = rows.indexWhere((row) => row[0].toString() == oldRcno, 1);
  //         rows[indexToEdit] = data.toList();
  //         String csvDataUpdated = const ListToCsvConverter().convert(rows, convertNullTo: '');
  //         await file.writeAsString(csvDataUpdated);
  //       } else {
  //         // if different month as old row, delete the row from the old csv
  //         final oldFile = File('$directoryPath/${stringToFilename(oldDate)}.csv');
  //         final oldCsvData = await oldFile.readAsString();
  //         List<List<dynamic>> oldRows = const CsvToListConverter().convert(oldCsvData);
  //         final indexToRemove = oldRows.indexWhere((row) => row[0].toString() == oldRcno, 1);
  //         oldRows.removeAt(indexToRemove);
  //         String csvDataUpdated = const ListToCsvConverter().convert(oldRows, convertNullTo: '');
  //         await oldFile.writeAsString(csvDataUpdated);

  //         if (await file.exists()) {
  //           // append new data to csv
  //           List<List<dynamic>> csvRow = [data.toList()];
  //           String csvData = const ListToCsvConverter().convert(csvRow, convertNullTo: '');
  //           await file.writeAsString('\r\n$csvData', mode: FileMode.append);
  //         } else {
  //           // create a new csv file and insert the header with the data
  //           List<List<dynamic>> csvTable = [header, data.toList()];
  //           String csvData = const ListToCsvConverter().convert(csvTable, convertNullTo: '');
  //           await file.writeAsString(csvData);
  //         }
  //       }
  //     } else {
  //       if (await file.exists()) {
  //         // append new data to csv
  //         List<List<dynamic>> csvRow = [data.toList()];
  //         String csvData = const ListToCsvConverter().convert(csvRow, convertNullTo: '');
  //         await file.writeAsString('\r\n$csvData', mode: FileMode.append);
  //       } else {
  //         // create a new csv file and insert the header with the data
  //         List<List<dynamic>> csvTable = [header, data.toList()];
  //         String csvData = const ListToCsvConverter().convert(csvTable, convertNullTo: '');
  //         await file.writeAsString(csvData);
  //       }
  //     }
  //   } catch (e) {
  //     return;
  //   }
  // }

  // Future<List<List<dynamic>>> readCsvFromDirectory() async {
  //   final directoryPath = await getExternalSdCardPath();
  //   if (directoryPath == null) {
  //     return [];
  //   }

  //   final directory = Directory(directoryPath);
  //   if (!await directory.exists()) {
  //     return [];
  //   }

  //   final csvFiles = directory.listSync().where((file) => file.path.endsWith('.csv')).toList();

  //   List<List<dynamic>> allRows = [];
  //   for (var fileEntity in csvFiles) {
  //     if (fileEntity is File) {
  //       try {
  //         final csvData = await fileEntity.readAsString();
  //         List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
  //         rows.removeAt(0);
  //         allRows.addAll(rows);
  //       } catch (e) {
  //         continue;
  //       }
  //     }
  //   }

  //   return allRows;
  // }

  // Future<List<dynamic>> getRCsList() async {
  //   final lists = await readCsvFromDirectory();
  //   // return lists.map((list) => listToRC(list)).toList();
  //   return lists;
  // }

  // Future<void> deleteRowFromCsv(dynamic data) async {
  //   final directoryPath = await getExternalSdCardPath();
  //   if (directoryPath == null) {
  //     return;
  //   }

  //   final directory = Directory(directoryPath);
  //   if (!await directory.exists()) {
  //     return;
  //   }

  //   final file = File('$directoryPath/${stringToFilename(data.date!)}.csv');

  //   final csvData = await file.readAsString();
  //   List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

  //   final indexToDelete = rows.indexWhere((row) => row[0].toString() == data.rcno.toString(), 1);
  //   rows.removeAt(indexToDelete);

  //   String csvDataUpdated = const ListToCsvConverter().convert(rows, convertNullTo: '');
  //   await file.writeAsString(csvDataUpdated);
  // }
}

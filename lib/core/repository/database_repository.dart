import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pat_app/core/controllers/files_controller.dart';
import 'package:pat_app/core/controllers/setup_controller.dart';
import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/resources/formatters.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/features/proceed_shipment/domain/models/shipped_result.dart';
import 'package:pat_app/injection_container.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<Employee> checkUserInformation(String data) async {
    final serverIP = sl<SetupController>().getServerIP();
    final timeoutSec = sl<SetupController>().getTimeoutSec();
    const api = "catalog/check_user_information/";

    try {
      final response = await http
          .post(
            Uri.parse("$serverIP$api"),
            body: jsonEncode(
              <String, String>{
                "Employee_ID": data,
              },
            ),
          )
          .timeout(Duration(seconds: timeoutSec));

      if (response.statusCode != 200) {
        throw Exception();
      } else {
        final responseData = json.decode(response.body);
        if (responseData['status'] != "OK") {
          throw Exception();
        } else {
          return Employee.fromJson(responseData['data'][0]);
        }
      }
    } on SocketException catch (_) {
      throw const SocketException("");
    } on TimeoutException catch (_) {
      throw TimeoutException("");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RC>> getShippedItems(String data) async {
    final serverIP = sl<SetupController>().getServerIP();
    final timeoutSec = sl<SetupController>().getTimeoutSec();
    const api = "catalog/get_shipped_items/";

    try {
      final response = await http
          .post(
            Uri.parse("$serverIP$api"),
            body: jsonEncode(
              <String, String>{
                "result_data": data,
              },
            ),
          )
          .timeout(Duration(seconds: timeoutSec));

      if (response.statusCode != 200) {
        throw Exception();
      } else {
        final responseData = json.decode(response.body);
        if (responseData['status'] != "OK") {
          throw Exception(responseData['tip_messages']);
        } else {
          return List<RC>.from(responseData['data'].map((item) => RC.fromJson(item)));
        }
      }
    } on SocketException catch (_) {
      throw const SocketException("");
    } on TimeoutException catch (_) {
      throw TimeoutException("");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ShippedResult> getShippedResult(String data) async {
    final serverIP = sl<SetupController>().getServerIP();
    final timeoutSec = sl<SetupController>().getTimeoutSec();
    const api = "catalog/get_shipped_result/";

    final electronicSignatureUint8List = sl<FilesController>().getElectronicSignature();
    final workIdPhotoUint8List = sl<FilesController>().getWorkIdPhoto();

    final splitData = data.split('\n');
    final employeeID = splitData[0];
    final shippedItem = splitData[1];

    try {
      final electronicSignatureFile = await sl<FilesController>().saveImageToDirectory(electronicSignatureUint8List, 'signature.png');
      final workIdPhotoFile = await sl<FilesController>().saveImageToDirectory(workIdPhotoUint8List, 'workIdPic.jpg');

      // multipart form post

      // rename folder
      final folderName = '${dateTimeToFolderName(DateTime.now())}_$employeeID';

      return ShippedResult.fromJson({"Employee_ID": employeeID, "Shipped items": shippedItem});
    } on SocketException catch (_) {
      throw const SocketException("");
    } on TimeoutException catch (_) {
      throw TimeoutException("");
    } catch (e) {
      rethrow;
    }
  }
}

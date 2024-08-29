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

    const electronicSignatureFileName = "Electronic Signature.jpg";
    const workIdPhotoFileName = "Work ID Photo.jpg";
    const recordFileName = "Record.txt";

    final electronicSignatureUint8List = sl<FilesController>().getElectronicSignature();
    final workIdPhotoUint8List = sl<FilesController>().getWorkIdPhoto();

    final splitData = data.split('\n');
    final employeeID = splitData[0];
    final shippedItems = splitData[1];

    try {
      // multipart form post
      var request = http.MultipartRequest('POST', Uri.parse("$serverIP$api"));
      final electronicSignatureImg = http.MultipartFile.fromBytes('Electronic Signature', electronicSignatureUint8List, filename: electronicSignatureFileName);
      final workIdPhotoImg = http.MultipartFile.fromBytes('Work ID Photo', workIdPhotoUint8List, filename: workIdPhotoFileName);

      request.files.add(electronicSignatureImg);
      request.files.add(workIdPhotoImg);

      request.fields['Employee_ID'] = employeeID;
      request.fields['Shipped items'] = shippedItems;

      // Send the request
      final streamedResponse = await request.send().timeout(Duration(seconds: timeoutSec));

      // Wait for the response
      final response = await http.Response.fromStream(streamedResponse).timeout(Duration(seconds: timeoutSec));
      final now = DateTime.now();

      // Check the response status code
      if (response.statusCode != 200) {
        throw Exception();
      }

      final responseData = json.decode(response.body);

      // Check the response data status
      if (responseData['status'] != "OK") {
        throw Exception(responseData['detail']);
      }

      // Save images to directory
      final folderName = '${dateTimeToFolderName(now)}_$employeeID';
      await sl<FilesController>().saveImageToDirectory(electronicSignatureUint8List, folderName, electronicSignatureFileName);
      await sl<FilesController>().saveImageToDirectory(workIdPhotoUint8List, folderName, workIdPhotoFileName);
      await sl<FilesController>().saveTextToFile("$employeeID,$shippedItems", folderName, recordFileName);

      // Return the result from the JSON response
      return ShippedResult.fromJson(responseData['data']);
    } on SocketException catch (_) {
      throw const SocketException("");
    } on TimeoutException catch (_) {
      throw TimeoutException("");
    } catch (e) {
      rethrow;
    }
  }
}

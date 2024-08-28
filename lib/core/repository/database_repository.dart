import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pat_app/core/controllers/setup_controller.dart';
import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/injection_container.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<Employee?> loginEmployee(String data) async {
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
  Future<List<RC>> getRCsList(String data) async {
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
          throw Exception();
        } else {
          throw Exception();
        }
      }
    } on SocketException catch (_) {
      throw const SocketException("");
    } on TimeoutException catch (_) {
      throw TimeoutException("");
    } catch (e) {
      return Future.value([]);
    }
  }
}

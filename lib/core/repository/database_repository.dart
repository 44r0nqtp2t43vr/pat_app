import 'dart:async';
import 'dart:io';

import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';
import 'package:pat_app/features/input_shipment/domain/models/get_rcs_list_data.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<Employee?> loginEmployee(String employeeID) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (employeeID.trim().isEmpty) {
        throw Exception();
      }

      return Future.value(const Employee(id: "EMPLOYEE#0001", name: "JUMAR"));
    } on SocketException catch (_) {
      throw const SocketException("");
    } on TimeoutException catch (_) {
      throw TimeoutException("");
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<List<RC>> getRCsList(GetRCsListData data) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final sampleData = [
        RC(
          rcno: "P0000000001",
          date: "2024-01-30",
          customerName: "JUMJUM",
          productPartNumber: "123456",
          numberOfShipmentBoxes: 10,
        ),
        RC(
          rcno: "P0000000002",
          date: "2024-01-29",
          customerName: "JUMJUM",
          productPartNumber: "123456",
          numberOfShipmentBoxes: 10,
        ),
        RC(
          rcno: "P0000000003",
          date: "2024-01-28",
          customerName: "JUMJUM",
          productPartNumber: "123456",
          numberOfShipmentBoxes: 10,
        ),
        RC(
          rcno: "P0000000004",
          date: "2024-01-27",
          customerName: "JUMJUM",
          productPartNumber: "123456",
          numberOfShipmentBoxes: 10,
        ),
        RC(
          rcno: "P0000000005",
          date: "2024-01-26",
          customerName: "JUMJUM",
          productPartNumber: "123456",
          numberOfShipmentBoxes: 10,
        ),
      ];

      if (data.isTextInput) {
        return Future.value(sampleData);
      } else {
        return Future.value(sampleData);
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

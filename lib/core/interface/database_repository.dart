import 'package:pat_app/features/employee_login/domain/models/employee.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';
import 'package:pat_app/features/proceed_shipment/domain/models/shipped_result.dart';

abstract class DatabaseRepository {
  Future<Employee> checkUserInformation(String data);
  Future<List<RC>> getShippedItems(String data);
  Future<ShippedResult> getShippedResult(String data);
}

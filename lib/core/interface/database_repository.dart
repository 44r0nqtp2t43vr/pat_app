import 'package:pat_app/features/employee_login/domain/models/employee.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

abstract class DatabaseRepository {
  Future<Employee?> loginEmployee(String data);
  Future<List<RC>> getRCsList(String data);
}

import 'package:pat_app/features/employee_login/domain/models/employee.dart';

abstract class DatabaseRepository {
  Future<Employee?> loginEmployee(String employeeID);
}

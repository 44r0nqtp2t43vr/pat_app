import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<Employee?> loginEmployee(String employeeID) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (employeeID.trim().isEmpty) {
        throw Exception();
      }

      return Future.value(const Employee(id: "EMPLOYEE#0001", name: "JUMAR"));
    } catch (e) {
      return Future.value(null);
    }
  }
}

import 'dart:async';

import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/usecase/usecase.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';

class LoginEmployeeUseCase implements UseCase<Employee?, String?> {
  final DatabaseRepository _databaseRepository;

  LoginEmployeeUseCase(this._databaseRepository);

  @override
  Future<Employee?> call({String? params}) {
    try {
      return _databaseRepository.loginEmployee(params!);
    } catch (e) {
      rethrow;
    }
  }
}

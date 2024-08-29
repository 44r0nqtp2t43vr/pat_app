import 'dart:async';

import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/usecase/usecase.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';

class CheckUserInformationUseCase implements UseCase<Employee?, String?> {
  final DatabaseRepository _databaseRepository;

  CheckUserInformationUseCase(this._databaseRepository);

  @override
  Future<Employee?> call({String? params}) {
    try {
      return _databaseRepository.checkUserInformation(params!);
    } catch (e) {
      rethrow;
    }
  }
}

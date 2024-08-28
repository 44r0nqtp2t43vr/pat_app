import 'dart:async';

import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/usecase/usecase.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

class GetRCsListUseCase implements UseCase<List<RC>, String> {
  final DatabaseRepository _databaseRepository;

  GetRCsListUseCase(this._databaseRepository);

  @override
  Future<List<RC>> call({String? params}) {
    try {
      return _databaseRepository.getRCsList(params!);
    } catch (e) {
      rethrow;
    }
  }
}

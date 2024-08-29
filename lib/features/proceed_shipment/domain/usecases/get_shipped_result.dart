import 'dart:async';

import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/usecase/usecase.dart';
import 'package:pat_app/features/proceed_shipment/domain/models/shipped_result.dart';

class GetShippedResultUseCase implements UseCase<ShippedResult, String> {
  final DatabaseRepository _databaseRepository;

  GetShippedResultUseCase(this._databaseRepository);

  @override
  Future<ShippedResult> call({String? params}) {
    try {
      return _databaseRepository.getShippedResult(params!);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:pat_app/features/proceed_shipment/domain/models/shipped_result.dart';

abstract class ShippedResultState extends Equatable {
  final ShippedResult? shippedResult;
  final dynamic exception;

  const ShippedResultState({this.shippedResult, this.exception});

  @override
  List<Object> get props => [shippedResult!, exception!];
}

class ShippedResultLoading extends ShippedResultState {
  const ShippedResultLoading();
}

class ShippedResultDone extends ShippedResultState {
  const ShippedResultDone({ShippedResult? shippedResult}) : super(shippedResult: shippedResult);
}

class ShippedResultError extends ShippedResultState {
  const ShippedResultError({dynamic exception}) : super(exception: exception);
}

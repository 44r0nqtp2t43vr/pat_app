import 'package:equatable/equatable.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

abstract class RCsListState extends Equatable {
  final List<RC>? rcsList;
  final dynamic exception;

  const RCsListState({this.rcsList, this.exception});

  @override
  List<Object> get props => [rcsList!, exception!];
}

class RCsListLoading extends RCsListState {
  const RCsListLoading();
}

class RCsListDone extends RCsListState {
  const RCsListDone({List<RC>? rcsList}) : super(rcsList: rcsList);
}

class RCsListError extends RCsListState {
  const RCsListError({dynamic exception}) : super(exception: exception);
}

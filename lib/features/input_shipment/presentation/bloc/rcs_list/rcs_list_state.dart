import 'package:equatable/equatable.dart';
import 'package:pat_app/features/input_shipment/domain/models/rc.dart';

abstract class RCsListState extends Equatable {
  final List<RC>? rcsList;
  final String? errorMessage;

  const RCsListState({this.rcsList, this.errorMessage});

  @override
  List<Object> get props => [rcsList!, errorMessage!];
}

class RCsListLoading extends RCsListState {
  const RCsListLoading();
}

class RCsListDone extends RCsListState {
  const RCsListDone({List<RC>? rcsList}) : super(rcsList: rcsList);
}

class RCsListError extends RCsListState {
  const RCsListError({String? errorMessage}) : super(errorMessage: errorMessage);
}

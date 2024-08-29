import 'package:equatable/equatable.dart';

abstract class ShippedResultEvent extends Equatable {
  final String? getShippedResultData;

  const ShippedResultEvent({this.getShippedResultData});

  @override
  List<Object> get props => [getShippedResultData!];
}

class GetShippedResultEvent extends ShippedResultEvent {
  const GetShippedResultEvent({String? getShippedResultData}) : super(getShippedResultData: getShippedResultData);
}

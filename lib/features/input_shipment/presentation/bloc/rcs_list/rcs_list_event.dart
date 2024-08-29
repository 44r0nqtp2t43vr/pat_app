import 'package:equatable/equatable.dart';

abstract class RCsListEvent extends Equatable {
  final String? getShippedItemsData;

  const RCsListEvent({this.getShippedItemsData});

  @override
  List<Object> get props => [getShippedItemsData!];
}

class GetShippedItemsEvent extends RCsListEvent {
  const GetShippedItemsEvent({String? getShippedItemsData}) : super(getShippedItemsData: getShippedItemsData);
}

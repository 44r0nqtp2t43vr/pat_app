import 'package:equatable/equatable.dart';

abstract class RCsListEvent extends Equatable {
  final String? getRCsListData;

  const RCsListEvent({this.getRCsListData});

  @override
  List<Object> get props => [getRCsListData!];
}

class GetRCsListEvent extends RCsListEvent {
  const GetRCsListEvent({String? getRCsListData}) : super(getRCsListData: getRCsListData);
}

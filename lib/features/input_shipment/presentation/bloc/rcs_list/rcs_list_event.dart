import 'package:equatable/equatable.dart';
import 'package:pat_app/features/input_shipment/domain/models/get_rcs_list_data.dart';

abstract class RCsListEvent extends Equatable {
  final GetRCsListData? getRCsListData;

  const RCsListEvent({this.getRCsListData});

  @override
  List<Object> get props => [getRCsListData!];
}

class GetRCsListEvent extends RCsListEvent {
  const GetRCsListEvent({GetRCsListData? getRCsListData}) : super(getRCsListData: getRCsListData);
}

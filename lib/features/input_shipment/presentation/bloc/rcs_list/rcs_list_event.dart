import 'package:equatable/equatable.dart';

abstract class RCsListEvent extends Equatable {
  const RCsListEvent();

  @override
  List<Object> get props => [];
}

class GetRCsListEvent extends RCsListEvent {
  const GetRCsListEvent() : super();
}

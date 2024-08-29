import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  final String? employeeID;

  const EmployeeEvent({this.employeeID});

  @override
  List<Object> get props => [employeeID!];
}

class CheckUserInformationEvent extends EmployeeEvent {
  const CheckUserInformationEvent(String? employeeID) : super(employeeID: employeeID);
}

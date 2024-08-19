import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  final String? employeeID;

  const EmployeeEvent({this.employeeID});

  @override
  List<Object> get props => [employeeID!];
}

class LoginEmployeeEvent extends EmployeeEvent {
  const LoginEmployeeEvent(String? employeeID) : super(employeeID: employeeID);
}

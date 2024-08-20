import 'package:equatable/equatable.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';

abstract class EmployeeState extends Equatable {
  final Employee? employee;
  final dynamic exception;

  const EmployeeState({this.employee, this.exception});

  @override
  List<Object> get props => [employee!, exception!];
}

class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

class EmployeeDone extends EmployeeState {
  const EmployeeDone({Employee? employee}) : super(employee: employee);
}

class EmployeeError extends EmployeeState {
  const EmployeeError({dynamic exception}) : super(exception: exception);
}

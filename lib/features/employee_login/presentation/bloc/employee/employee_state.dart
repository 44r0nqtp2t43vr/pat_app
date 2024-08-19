import 'package:equatable/equatable.dart';
import 'package:pat_app/features/employee_login/domain/models/employee.dart';

abstract class EmployeeState extends Equatable {
  final Employee? employee;
  final String? errorMessage;

  const EmployeeState({this.employee, this.errorMessage});

  @override
  List<Object> get props => [employee!, errorMessage!];
}

class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

class EmployeeDone extends EmployeeState {
  const EmployeeDone({Employee? employee}) : super(employee: employee);
}

class EmployeeError extends EmployeeState {
  const EmployeeError({String? errorMessage}) : super(errorMessage: errorMessage);
}

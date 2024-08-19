import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/features/employee_login/domain/usecases/login_employee.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_event.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final LoginEmployeeUseCase _loginEmployeeUseCase;

  EmployeeBloc(
    this._loginEmployeeUseCase,
  ) : super(const EmployeeLoading()) {
    on<LoginEmployeeEvent>(onLoginEmployee);
  }

  void onLoginEmployee(LoginEmployeeEvent event, Emitter<EmployeeState> emit) async {
    emit(const EmployeeLoading());

    final employee = await _loginEmployeeUseCase(params: event.employeeID!);

    if (employee == null) {
      emit(const EmployeeError());
    } else {
      emit(EmployeeDone(employee: employee));
    }
  }
}

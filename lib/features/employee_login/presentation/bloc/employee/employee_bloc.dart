import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/features/employee_login/domain/usecases/check_user_information.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_event.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final CheckUserInformationUseCase _checkUserInformationUseCase;

  EmployeeBloc(
    this._checkUserInformationUseCase,
  ) : super(const EmployeeLoading()) {
    on<CheckUserInformationEvent>(onCheckUserInformation);
  }

  void onCheckUserInformation(CheckUserInformationEvent event, Emitter<EmployeeState> emit) async {
    emit(const EmployeeLoading());

    try {
      final employee = await _checkUserInformationUseCase(params: event.employeeID!);

      emit(EmployeeDone(employee: employee));
    } catch (e) {
      emit(EmployeeError(exception: e));
    }
  }
}

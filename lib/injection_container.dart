import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/repository/database_repository.dart';
import 'package:pat_app/features/employee_login/domain/usecases/login_employee.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies

  sl.registerSingleton<DatabaseRepository>(DatabaseRepositoryImpl());

  sl.registerSingleton<LanguageController>(LanguageController());

  Get.put<LanguageController>(sl());

  // UseCases

  sl.registerSingleton<LoginEmployeeUseCase>(LoginEmployeeUseCase(sl()));

  // Blocs

  sl.registerFactory<EmployeeBloc>(() => EmployeeBloc(sl()));
}

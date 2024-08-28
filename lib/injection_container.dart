import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pat_app/core/controllers/files_controller.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/controllers/selected_rcs_list_controller.dart';
import 'package:pat_app/core/controllers/setup_controller.dart';
import 'package:pat_app/core/interface/database_repository.dart';
import 'package:pat_app/core/repository/database_repository.dart';
import 'package:pat_app/features/employee_login/domain/usecases/login_employee.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/input_shipment/domain/usecases/get_rcs_list.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies

  sl.registerSingleton<DatabaseRepository>(DatabaseRepositoryImpl());

  sl.registerSingleton<LanguageController>(LanguageController());

  Get.put<LanguageController>(sl());

  sl.registerSingleton<SelectedRCsListController>(SelectedRCsListController());

  Get.put<SelectedRCsListController>(sl());

  sl.registerSingleton<SetupController>(SetupController());

  Get.put<SetupController>(sl());

  sl.registerSingleton<FilesController>(FilesController());

  Get.put<FilesController>(sl());

  // UseCases

  sl.registerSingleton<LoginEmployeeUseCase>(LoginEmployeeUseCase(sl()));

  sl.registerSingleton<GetRCsListUseCase>(GetRCsListUseCase(sl()));

  // Blocs

  sl.registerFactory<EmployeeBloc>(() => EmployeeBloc(sl()));

  sl.registerFactory<RCsListBloc>(() => RCsListBloc(sl()));
}

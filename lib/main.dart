import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/config/routes/routes.dart';
import 'package:pat_app/config/theme/app_themes.dart';
import 'package:pat_app/features/employee_login/presentation/bloc/employee/employee_bloc.dart';
import 'package:pat_app/features/employee_login/presentation/screens/main_menu/main_menu.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_bloc.dart';
import 'package:pat_app/injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(create: (BuildContext context) => sl()),
        BlocProvider<RCsListBloc>(create: (BuildContext context) => sl()),
      ],
      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const MainMenu(),
      ),
    );
  }
}

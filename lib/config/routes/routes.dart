import 'package:flutter/material.dart';
import 'package:pat_app/features/employee_login/presentation/screens/main_menu/main_menu.dart';
import 'package:pat_app/features/employee_login/presentation/screens/user_login/user_login.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/select_entries/select_entries.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const MainMenu());

      case '/userLogin':
        return _materialRoute(const UserLogin());

      case '/selectEntries':
        return _materialRoute(const SelectEntries());

      default:
        return _materialRoute(const MainMenu());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view, maintainState: false);
  }
}

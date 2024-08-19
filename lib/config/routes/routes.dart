import 'package:flutter/material.dart';
import 'package:pat_app/features/employee_login/presentation/screens/main_menu/main_menu.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const MainMenu());

      default:
        return _materialRoute(const MainMenu());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view, maintainState: false);
  }
}

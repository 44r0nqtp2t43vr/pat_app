import 'package:flutter/material.dart';
import 'package:pat_app/features/employee_login/presentation/screens/main_menu/main_menu.dart';
import 'package:pat_app/features/employee_login/presentation/screens/user_login/user_login.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/check_shipment/check_shipment.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/confirm_shipment/confirm_shipment.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/data_error/data_error.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/process_entries/process_entries.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/select_entries/select_entries.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/delivery_driver/delivery_driver.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const MainMenu());

      case '/userLogin':
        return _materialRoute(const UserLogin());

      case '/selectEntries':
        return _materialRoute(const SelectEntries());

      case '/processEntries':
        return _materialRoute(const ProcessEntries());

      case '/dataError':
        return _materialRoute(const DataError());

      case '/confirmShipment':
        return _materialRoute(const ConfirmShipment());

      case '/checkShipment':
        return _materialRoute(const CheckShipment());

      case '/deliveryDriver':
        return _materialRoute(const DeliveryDriver());

      default:
        return _materialRoute(const MainMenu());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view, maintainState: false);
  }
}

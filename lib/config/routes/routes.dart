import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pat_app/features/employee_login/presentation/screens/employee_id_error/employee_id_error.dart';
import 'package:pat_app/features/employee_login/presentation/screens/network_error/network_error.dart';
import 'package:pat_app/features/employee_login/presentation/screens/user_login/user_login.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/check_shipment/check_shipment.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/confirm_shipment/confirm_shipment.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/data_error/data_error.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/process_entries/process_entries.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/select_entries/select_entries.dart';
import 'package:pat_app/features/input_shipment/presentation/screens/select_via/select_via.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/confirm_save/confirm_save.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/delivery_driver/delivery_driver.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/electronic_signature/electronic_signature.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/post_error/post_error.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/work_id_photo/work_id_photo.dart';
import 'package:pat_app/features/proceed_shipment/presentation/screens/work_id_photo_preview/work_id_photo_preview.dart';
import 'package:pat_app/features/setup/presentation/screens/input_password/input_password.dart';
import 'package:pat_app/features/setup/presentation/screens/input_setup/input_setup.dart';
import 'package:pat_app/features/setup/presentation/screens/password_error/password_error.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const UserLogin());

      case '/inputPassword':
        return _materialRoute(const InputPassword());

      case '/inputSetup':
        return _materialRoute(const InputSetup());

      case '/passwordError':
        return _materialRoute(const PasswordError());

      case '/networkError':
        return _materialRoute(NetworkError(state: settings.arguments as dynamic));

      case '/employeeIDError':
        return _materialRoute(const EmployeeIDError());

      case '/userLogin':
        return _materialRoute(const UserLogin());

      case '/selectVia':
        return _materialRoute(const SelectVia());

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

      case '/electronicSignature':
        return _materialRoute(const ElectronicSignature());

      case '/workId':
        return _materialRoute(const WorkIdPhoto());

      case '/workIdPreview':
        return _materialRoute(WorkIdPhotoPreview(image: settings.arguments as XFile));

      case '/confirmSave':
        return _materialRoute(const ConfirmSave());

      case '/postError':
        return _materialRoute(const PostError());

      default:
        return _materialRoute(const UserLogin());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view, maintainState: false);
  }
}

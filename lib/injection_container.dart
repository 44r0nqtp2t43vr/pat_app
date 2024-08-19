import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pat_app/core/controllers/language_controller.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies

  sl.registerSingleton<LanguageController>(LanguageController());

  Get.put<LanguageController>(sl());

  // UseCases

  // Blocs
}

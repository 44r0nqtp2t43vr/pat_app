import 'package:get/get.dart';
import 'package:pat_app/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupController extends GetxController {
  final asyncPrefs = sl<SharedPreferencesAsync>();

  // Cached values using reactive variables
  RxString serverIP = "https://turncard.topfuntek.com/".obs;
  RxInt timeoutSec = 5.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialValues();
  }

  Future<void> _loadInitialValues() async {
    // Load saved values from SharedPreferences and update reactive state
    final savedServerIP = await asyncPrefs.getString('serverIP');
    final savedTimeoutSec = await asyncPrefs.getInt('timeoutSec');

    if (savedServerIP != null) {
      serverIP.value = savedServerIP;
    }
    if (savedTimeoutSec != null) {
      timeoutSec.value = savedTimeoutSec;
    }
  }

  String getServerIP() {
    return serverIP.value;
  }

  int getTimeoutSec() {
    return timeoutSec.value;
  }

  Future<void> setServerIP(String newServerIP) async {
    serverIP.value = newServerIP;
    await asyncPrefs.setString('serverIP', newServerIP);
  }

  Future<void> setTimeoutSec(int newTimeoutSec) async {
    timeoutSec.value = newTimeoutSec;
    await asyncPrefs.setInt('timeoutSec', newTimeoutSec);
  }
}

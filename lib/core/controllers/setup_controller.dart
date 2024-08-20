import 'package:get/get.dart';

class SetupController extends GetxController {
  Rx<String> serverIP = Rx<String>("");
  Rx<int> timeoutSec = Rx<int>(5);

  String getServerIP() {
    return serverIP.value;
  }

  int getTimeoutSec() {
    return timeoutSec.value;
  }

  void setServerIP(String newServerIP) {
    serverIP.value = newServerIP;
  }

  void setTimeoutSec(int newTimeoutSec) {
    timeoutSec.value = newTimeoutSec;
  }
}

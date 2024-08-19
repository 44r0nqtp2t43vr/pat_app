import 'package:get/get.dart';

enum Language { english, chinese }

enum TextMeaning { userLogin, exit, employeeID, login, password, passwordError, rcNo, confirm }

class LanguageController extends GetxController {
  Rx<Language> currentLanguage = Rx<Language>(Language.english);

  Language getCurrentLanguage() {
    return currentLanguage.value;
  }

  void setCurrentLanguage(Language newLanguage) {
    currentLanguage.value = newLanguage;
    update();
  }

  void toggleCurrentLanguage() {
    if (getCurrentLanguage() == Language.english) {
      setCurrentLanguage(Language.chinese);
    } else {
      setCurrentLanguage(Language.english);
    }
  }

  String translate(TextMeaning textMeaning) {
    switch (textMeaning) {
      case TextMeaning.userLogin:
        return getCurrentLanguage() == Language.english ? "USER LOGIN" : "使用者登入";
      case TextMeaning.exit:
        return getCurrentLanguage() == Language.english ? "EXIT" : "離開";
      case TextMeaning.employeeID:
        return getCurrentLanguage() == Language.english ? "Employee ID" : "工號";
      case TextMeaning.login:
        return getCurrentLanguage() == Language.english ? "LOGIN" : "登入";
      case TextMeaning.password:
        return getCurrentLanguage() == Language.english ? "PASSWORD" : "密碼";
      case TextMeaning.passwordError:
        return getCurrentLanguage() == Language.english ? "PASSWORD ERROR!!\n\nPlease contact to technical support!" : "密碼錯誤!!\n\n請洽技術人員!!";
      case TextMeaning.rcNo:
        return getCurrentLanguage() == Language.english ? "RC No." : "RC No.";
      case TextMeaning.confirm:
        return getCurrentLanguage() == Language.english ? "CONFIRM" : "確認";
      default:
        return "BUTTON";
    }
  }
}

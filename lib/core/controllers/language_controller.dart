import 'package:get/get.dart';

enum Language { english, chinese }

enum TextMeaning { userLogin, exit }

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
      default:
        return "BUTTON";
    }
  }
}

import 'package:get/get.dart';

enum Language {
  english,
  chinese,
}

enum TextMeaning {
  userLogin,
  exit,
  employeeID,
  login,
  password,
  passwordError,
  rcNo,
  confirm,
  numberOfEntriesSelectedInBatch,
  processingEntryNumber,
  customerName,
  productPartNumber,
  next,
  totalNumberOfShipmentBoxes,
  quantityOfProductsInTheLastShipmentBox,
  totalNumberOfShipmentBoxesHint,
  quantityOfProductsInTheLastShipmentBoxHint,
  dataError,
  backForCheck,
  name,
  toCheckShipmentDetails,
  cancelThisShipment,
  proceedWithShipment,
  chooseOneFromTheOptionsBelow,
  deliveryDriver,
  electronicSignature,
  workIDPhoto,
  modification,
  clear,
  takePhoto,
  retakePhoto,
}

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
        return getCurrentLanguage() == Language.english
            ? "USER LOGIN"
            : "使用者登入";
      case TextMeaning.exit:
        return getCurrentLanguage() == Language.english ? "EXIT" : "離開";
      case TextMeaning.employeeID:
        return getCurrentLanguage() == Language.english ? "Employee ID" : "工號";
      case TextMeaning.login:
        return getCurrentLanguage() == Language.english ? "LOGIN" : "登入";
      case TextMeaning.password:
        return getCurrentLanguage() == Language.english ? "PASSWORD" : "密碼";
      case TextMeaning.passwordError:
        return getCurrentLanguage() == Language.english
            ? "PASSWORD ERROR!!\n\nPlease contact to technical support!"
            : "密碼錯誤!!\n\n請洽技術人員!!";
      case TextMeaning.rcNo:
        return getCurrentLanguage() == Language.english ? "RC No." : "RC No.";
      case TextMeaning.confirm:
        return getCurrentLanguage() == Language.english ? "CONFIRM" : "確認";
      case TextMeaning.numberOfEntriesSelectedInBatch:
        return getCurrentLanguage() == Language.english
            ? "Number of entries selected in batch"
            : "批次選取的資料筆數";
      case TextMeaning.processingEntryNumber:
        return getCurrentLanguage() == Language.english
            ? "Processing entry number"
            : "目前正在執行筆數為";
      case TextMeaning.customerName:
        return getCurrentLanguage() == Language.english
            ? "Customer Name"
            : "客戶名稱";
      case TextMeaning.productPartNumber:
        return getCurrentLanguage() == Language.english
            ? "Product Part Number"
            : "產品料號";
      case TextMeaning.next:
        return getCurrentLanguage() == Language.english ? "NEXT" : "下一頁";
      case TextMeaning.totalNumberOfShipmentBoxes:
        return getCurrentLanguage() == Language.english
            ? "Total Number of Shipment Boxes"
            : "出貨總箱數";
      case TextMeaning.quantityOfProductsInTheLastShipmentBox:
        return getCurrentLanguage() == Language.english
            ? "Quantity of Products in the Last Shipment Box"
            : "尾數箱產品數量";
      case TextMeaning.totalNumberOfShipmentBoxesHint:
        return getCurrentLanguage() == Language.english
            ? "Please enter the total number of shipment boxes"
            : "請輸入此出貨總箱數";
      case TextMeaning.quantityOfProductsInTheLastShipmentBoxHint:
        return getCurrentLanguage() == Language.english
            ? "Please enter the quantity of products in the last shipment box"
            : "請輸入尾數箱產品數量";
      case TextMeaning.dataError:
        return getCurrentLanguage() == Language.english
            ? "There is an ERROR in the data!\n\nPlease Re-Check!!"
            : "資料有錯誤!\n\n請重新檢查!";
      case TextMeaning.backForCheck:
        return getCurrentLanguage() == Language.english
            ? "BACK FOR CHECK"
            : "返回";
      case TextMeaning.name:
        return getCurrentLanguage() == Language.english ? "Name" : "姓名";
      case TextMeaning.toCheckShipmentDetails:
        return getCurrentLanguage() == Language.english
            ? "TO CHECK SHIPMENT DETAILS"
            : "出貨明細檢查";
      case TextMeaning.cancelThisShipment:
        return getCurrentLanguage() == Language.english
            ? "CANCEL THIS SHIPMENT"
            : "放棄本次操作";
      case TextMeaning.proceedWithShipment:
        return getCurrentLanguage() == Language.english
            ? "PROCEED WITH SHIPMENT"
            : "執行出貨";
      case TextMeaning.chooseOneFromTheOptionsBelow:
        return getCurrentLanguage() == Language.english
            ? "Choose one from the options below"
            : "下列兩種方式擇一即可";
      case TextMeaning.deliveryDriver:
        return getCurrentLanguage() == Language.english
            ? "Delivery Driver"
            : "收貨司機";
      case TextMeaning.electronicSignature:
        return getCurrentLanguage() == Language.english
            ? "ELECTRONIC SIGNATURE"
            : "電子簽名";
      case TextMeaning.workIDPhoto:
        return getCurrentLanguage() == Language.english
            ? "WORK ID PHOTO"
            : "工作證拍照";
      case TextMeaning.modification:
        return getCurrentLanguage() == Language.english ? "MODIFICATION" : "修改";
      case TextMeaning.clear:
        return getCurrentLanguage() == Language.english ? "CLEAR" : "清除";
      case TextMeaning.takePhoto:
        return getCurrentLanguage() == Language.english ? "TAKE PHOTO" : "拍照";
      case TextMeaning.retakePhoto:
        return getCurrentLanguage() == Language.english ? "RE-TAKE" : "重拍";
      default:
        return "BUTTON";
    }
  }
}

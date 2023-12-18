import 'package:get/get.dart';

class QRCodeGenerateController extends GetxController {
  RxString generateQr = "".obs;
  RxString dataQr = "".obs;
  RxBool generateCondition = false.obs;

  generateQrCode() {
    generateQr.value = dataQr.value;
    generateCondition.value = true;
  }

  generateQrCondition() {
    generateCondition.value = false;
    dataQr.value = "";
  }
}

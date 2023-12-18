import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner/Views/qr_code_module_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Views/qr_code_scanner_view.dart';

class QRCodeScannerController extends GetxController {
  RxString barcodeResult = "".obs;

  Future<void> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#FF0000",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );

    if (barcode == '-1') {
      barcodeResult.value = '';
      Get.offAll(QrCodeModuleView());
    } else {
      barcodeResult.value = barcode;
      Get.offAll(QRCodeScannerView());
    }
  }

  scanBarcodeClear() {
    barcodeResult.value = '';
    Get.offAll(QrCodeModuleView());
  }

  void copyTextToClipboard() {
    Clipboard.setData(ClipboardData(text: barcodeResult.value));
  }

  void shareText() {
    Share.share(barcodeResult.value);
  }

  void launchGoogleSearch() async {
    String searchTerm = barcodeResult.value;
    String url = 'https://www.google.com/search?q=$searchTerm';
    // ignore: deprecated_member_use
    await launch(url);
  }
}

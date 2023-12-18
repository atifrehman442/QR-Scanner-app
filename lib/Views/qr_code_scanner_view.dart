import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/Controllers/qr_code_scanner_controller.dart';
import 'package:qr_scanner/Custom/customButton.dart';
import 'package:qr_scanner/Styles/app_colors.dart';

class QRCodeScannerView extends StatefulWidget {
  @override
  _QRCodeScannerViewState createState() => _QRCodeScannerViewState();
}

class _QRCodeScannerViewState extends State<QRCodeScannerView> {
  final _QRCodeScannerController = Get.put(QRCodeScannerController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Obx(
                () => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width * 0.8,
                          height: screenSize.height * 0.8,
                          child: Text(
                            '${_QRCodeScannerController.barcodeResult}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 60.w),
                        Row(
                          children: [
                            _QRCodeScannerController.barcodeResult != ""
                                ? InkWell(
                                    onTap: _QRCodeScannerController
                                        .copyTextToClipboard,
                                    child: Icon(
                                      Icons.copy,
                                      size: 30,
                                      color: themeController.isDarkMode.value
                                          ? AppColor.buttonColorWhite
                                          : AppColor.buttonColorBlue,
                                    ))
                                : Text(""),
                            SizedBox(width: 10.w),
                            _QRCodeScannerController.barcodeResult != ""
                                ? Row(
                                    children: [
                                      CustomButton(
                                        color: themeController.isDarkMode.value
                                            ? AppColor.buttonColorWhite
                                            : AppColor.buttonColorBlue,
                                        textColor:
                                            themeController.isDarkMode.value
                                                ? AppColor.textColorWhite
                                                : AppColor.textColorBlack,
                                        height: screenSize.height / 18,
                                        width: screenSize.width / 6,
                                        borderColor: Colors.transparent,
                                        text: "Scan Barcode",
                                        onPressed: _QRCodeScannerController
                                            .scanBarcode,
                                      ),
                                    ],
                                  )
                                : Text(""),
                            _QRCodeScannerController.barcodeResult != ""
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10.w),
                                      CustomButton(
                                        color: themeController.isDarkMode.value
                                            ? AppColor.buttonColorWhite
                                            : AppColor.buttonColorBlue,
                                        textColor:
                                            themeController.isDarkMode.value
                                                ? AppColor.textColorWhite
                                                : AppColor.textColorBlack,
                                        height: screenSize.height / 18,
                                        width: screenSize.width / 7,
                                        borderColor: Colors.transparent,
                                        text: "Back",
                                        onPressed: _QRCodeScannerController
                                            .scanBarcodeClear,
                                      ),
                                    ],
                                  )
                                : Text(""),
                            _QRCodeScannerController.barcodeResult != ""
                                ? Row(
                                    children: [
                                      SizedBox(width: 10.w),
                                      CustomButton(
                                          color:
                                              themeController.isDarkMode.value
                                                  ? AppColor.buttonColorWhite
                                                  : AppColor.buttonColorBlue,
                                          textColor:
                                              themeController.isDarkMode.value
                                                  ? AppColor.textColorWhite
                                                  : AppColor.textColorBlack,
                                          height: screenSize.height / 18,
                                          width: screenSize.width / 7,
                                          borderColor: Colors.transparent,
                                          text: "Search",
                                          onPressed: _QRCodeScannerController
                                              .launchGoogleSearch),
                                      SizedBox(width: 10.w),
                                    ],
                                  )
                                : Text(""),
                            _QRCodeScannerController.barcodeResult != ""
                                ? GestureDetector(
                                    onTap: _QRCodeScannerController.shareText,
                                    child: Icon(
                                      Icons.share,
                                      size: 30,
                                      color: themeController.isDarkMode.value
                                          ? AppColor.buttonColorWhite
                                          : AppColor.buttonColorBlue,
                                    ),
                                  )
                                : Text(""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

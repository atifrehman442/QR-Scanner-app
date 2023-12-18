import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/Controllers/qr_code_module_controller.dart';
import 'package:qr_scanner/Custom/customButton.dart';
import 'package:qr_scanner/Styles/app_colors.dart';
import 'package:qr_scanner/Views/qr_code_generate_view.dart';
import '../Controllers/qr_code_scanner_controller.dart';
import '../Controllers/theme_controller.dart';

class QrCodeModuleView extends StatelessWidget {
  QrCodeModuleView({Key? key}) : super(key: key);

  final qrCodeModuleController = Get.put(QrCodeModuleController());
  final _QRCodeScannerController = Get.put(QRCodeScannerController());
  final themeController =
      Get.put(ThemeController()); // Get your theme controller

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
        centerTitle: true,
        actions: [
          Container(
            width: 30.w,
            child: GestureDetector(
              onTap: () {
                qrCodeModuleController.changeIcon();
                themeController.toggleDarkMode();
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              child: Obx(
                () => Icon(
                  qrCodeModuleController.icon.value,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                  color: themeController.isDarkMode.value
                      ? AppColor.buttonColorWhite
                      : AppColor.buttonColorBlue,
                  textColor: themeController.isDarkMode.value
                      ? AppColor.textColorWhite
                      : AppColor.textColorBlack,
                  height: screenSize.height / 14,
                  width: screenSize.width * 0.4,
                  borderColor: Colors.transparent,
                  text: 'QR Code Scanner',
                  onPressed: _QRCodeScannerController.scanBarcode),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Get.to(QRCodeGenerateView());
              //   },
              //   child: Text(
              //     'Generate QR Code',
              //   ),
              // ),
              CustomButton(
                color: themeController.isDarkMode.value
                    ? AppColor.buttonColorWhite
                    : AppColor.buttonColorBlue,
                textColor: themeController.isDarkMode.value
                    ? AppColor.textColorWhite
                    : AppColor.textColorBlack,
                height: screenSize.height / 14,
                width: screenSize.width * 0.4,
                borderColor: Colors.transparent,
                text: 'Generate QR Code',
                onPressed: () {
                  Get.to(QRCodeGenerateView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

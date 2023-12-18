import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/Controllers/qr_code_generate_controller.dart';
import 'package:qr_scanner/Custom/customButton.dart';
import 'package:qr_scanner/Styles/app_colors.dart';

import '../Controllers/theme_controller.dart';

class QRCodeGenerateView extends StatefulWidget {
  @override
  _QRCodeGenerateViewState createState() => _QRCodeGenerateViewState();
}

class _QRCodeGenerateViewState extends State<QRCodeGenerateView> {
  final ThemeController themeController = Get.put(ThemeController());
  final qrCodeGenerateController = Get.put(QRCodeGenerateController());
  final GlobalKey _qrkey = GlobalKey();

  Future<void> _captureAndSavePng() async {
    try {
      ///RenderRepaintBoundary object boundary create kiya jata hai. Is object ki madad se current context se QR code ko capture kiya jata hai.
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      //QR code black hota hai, is liye white background banaya jata hai, jisse QR code saaf dikh sake.

      //Ek PictureRecorder object recorder create kiya jata hai, jo ek canvas se image ko record karega.
      final whitePaint = Paint()
        ..color =
            themeController.isDarkMode.value ? Colors.black : Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      final result = await ImageGallerySaver.saveImage(
        pngBytes!,
        name: 'qr_code.png',
      );

      if (result != null) {
        // The image was saved successfully
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('QR code saved to gallery'),
        ));
      } else {
        // There was an error
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to save QR code'),
        ));
      }
    } catch (e) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Something went wrong!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generate"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Obx(
              () => qrCodeGenerateController.generateCondition.value == false
                  ? Container(
                      height: screenSize.height * 0.3,
                      width: screenSize.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: themeController.isDarkMode.value
                                ? AppColor.buttonColorWhite
                                : AppColor.buttonColorBlue,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (text) {
                            qrCodeGenerateController.dataQr.value = text;
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                              labelText: 'Enter Data',
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  : Text(""),
            ),
          ),
          SizedBox(height: 10),
          Obx(() => qrCodeGenerateController.generateCondition.value == true
              ? themeController.isDarkMode.value != false
                  ? RepaintBoundary(
                      key: _qrkey,
                      child: QrImageView(
                        data: qrCodeGenerateController.generateQr.value,
                        version: QrVersions.auto,
                        size: 250.0,
                        foregroundColor: Colors.white,
                        gapless: true,
                      ),
                    )
                  : RepaintBoundary(
                      key: _qrkey,
                      child: QrImageView(
                        data: qrCodeGenerateController.generateQr.value,
                        version: QrVersions.auto,
                        size: 250.0,
                        foregroundColor: Colors.black,
                        gapless: true,
                      ),
                    )
              : Text("")),
          SizedBox(height: 20),
          Obx(
            () => qrCodeGenerateController.generateCondition.value == false
                ? CustomButton(
                    color: themeController.isDarkMode.value
                        ? AppColor.buttonColorWhite
                        : AppColor.buttonColorBlue,
                    textColor: themeController.isDarkMode.value
                        ? AppColor.textColorWhite
                        : AppColor.textColorBlack,
                    height: screenSize.height / 18,
                    width: screenSize.width * 0.4,
                    borderColor: Colors.transparent,
                    text: 'Generate Barcode',
                    onPressed: () {
                      if (qrCodeGenerateController.dataQr.value != "") {
                        qrCodeGenerateController.generateQrCode();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Empty Field is not valid"),
                        ));
                      }
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        color: themeController.isDarkMode.value
                            ? AppColor.buttonColorWhite
                            : AppColor.buttonColorBlue,
                        textColor: themeController.isDarkMode.value
                            ? AppColor.textColorWhite
                            : AppColor.textColorBlack,
                        height: screenSize.height / 18,
                        width: screenSize.width * 0.2,
                        borderColor: Colors.transparent,
                        text: 'Cancel',
                        onPressed: qrCodeGenerateController.generateQrCondition,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomButton(
                        color: themeController.isDarkMode.value
                            ? AppColor.buttonColorWhite
                            : AppColor.buttonColorBlue,
                        textColor: themeController.isDarkMode.value
                            ? AppColor.textColorWhite
                            : AppColor.textColorBlack,
                        height: screenSize.height / 18,
                        width: screenSize.width * 0.2,
                        borderColor: Colors.transparent,
                        text: 'Download',
                        onPressed: _captureAndSavePng,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/Views/qr_code_module_view.dart';
import '../Controllers/qr_code_module_controller.dart';
import '../Controllers/theme_controller.dart';

class ThemViews extends StatefulWidget {
  @override
  State<ThemViews> createState() => _ThemViewsState();
}

class _ThemViewsState extends State<ThemViews> {
  @override
  void initState() {
    // TODO: implement initState
    final qrCodeModuleController = Get.put(QrCodeModuleController());
    qrCodeModuleController.loadIconFromSharedPreferences();
    super.initState();
  }

  // final qrCodeModuleController = Get.put(QrCodeModuleController());

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        theme: themeController.isDarkMode.value
            ? ThemeData.dark()
            : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // appBar: AppBar(
            //   title: Text("QR Code"),
            //   centerTitle: true,
            //   actions: [
            //     Container(
            //       width: 30.w,
            //       child: GestureDetector(
            //         onTap: () {
            //           qrCodeModuleController.changeIcon();
            //           themeController.toggleDarkMode();
            //           Get.changeTheme(Get.isDarkMode
            //               ? ThemeData.light()
            //               : ThemeData.dark());
            //         },
            //         child: Obx(
            //           () => Icon(
            //             qrCodeModuleController.icon.value,
            //             size: 30,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            body: QrCodeModuleView()),
      ),
    );
  }
}

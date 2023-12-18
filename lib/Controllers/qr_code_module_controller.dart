import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrCodeModuleController extends GetxController {
  var icon = Rx<IconData>(Icons.sunny);

  @override
  void onInit() {
    super.onInit();
    // Load the saved icon from SharedPreferences when the controller is initialized.
    loadIconFromSharedPreferences();
  }

  Future<void> changeIcon() async {
    if (icon.value == Icons.sunny) {
      icon.value = Icons.mode_night_rounded;
    } else {
      icon.value = Icons.sunny;
    }
    // Save the currently displayed icon to SharedPreferences.
    await saveIconToSharedPreferences(icon.value);
  }

  Future<void> saveIconToSharedPreferences(IconData iconData) async {
    // Encode the icon data as a base64 string
    String iconString = iconData.codePoint.toRadixString(16);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_icon', iconString);
  }

  Future<void> loadIconFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iconString = prefs.getString('saved_icon');

    if (iconString != null) {
      int codePoint = int.parse(iconString, radix: 16);
      icon.value = IconData(codePoint, fontFamily: 'MaterialIcons');
    }
  }
}

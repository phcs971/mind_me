import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../service/service.dart';
import '../utils.dart';

class SnackbarWidget {
  static final nav = Get.find<NavigationService>();

  static build(String message, {bool bottom = true}) {
    Get.rawSnackbar(
      backgroundColor: Colors.black.withOpacity(0.8),
      messageText: Text(message, style: MindMeStyles.caption.copyWith(color: Colors.white)),
      borderRadius: 8.0,
      duration: Duration(seconds: 4),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: bottom ? SnackPosition.BOTTOM : SnackPosition.TOP,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 32),
    );
  }

  static action(String message, String button, void Function() action, {bool bottom = true}) {
    Get.rawSnackbar(
      backgroundColor: Colors.black.withOpacity(0.8),
      messageText: Text(message, style: MindMeStyles.caption.copyWith(color: Colors.white)),
      borderRadius: 8.0,
      duration: Duration(seconds: 4),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: bottom ? SnackPosition.BOTTOM : SnackPosition.TOP,
      onTap: (_) => action(),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 32),
      mainButton: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12)),
        ),
        onPressed: action,
        child: Text(button, style: MindMeStyles.button2.copyWith(color: Colors.white)),
      ),
    );
  }

  static error(String message,
      {Function()? tryAgain, bool bottom = true, String tryAgainText = "TENTAR"}) {
    Get.rawSnackbar(
      backgroundColor: Colors.red.withOpacity(0.8),
      messageText: Text(message, style: MindMeStyles.body2.copyWith(color: Colors.white)),
      borderRadius: 8.0,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 32),
      duration: Duration(seconds: 4),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: bottom ? SnackPosition.BOTTOM : SnackPosition.TOP,
      onTap: tryAgain != null ? (_) => tryAgain() : (_) => nav.closeSnack(),
      mainButton: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12)),
        ),
        onPressed: tryAgain != null ? () => tryAgain() : nav.closeSnack,
        child: Text(
          tryAgain != null ? tryAgainText : "OK",
          style: MindMeStyles.button2.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

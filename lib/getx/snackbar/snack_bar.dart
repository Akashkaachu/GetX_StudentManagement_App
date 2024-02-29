import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbarController {
  void showCustomSnackbar(
      String title, String message, ContentType signIndicator) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),
      messageText: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: signIndicator,
      ),
    );
  }
}

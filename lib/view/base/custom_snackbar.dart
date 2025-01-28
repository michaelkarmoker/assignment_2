import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showCustomSnackBar(String message, {bool isError = true, bool isPosition= false} ) {
  Get.showSnackbar(GetBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,

    duration: Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(5),
    borderRadius: 5,
    isDismissible: true,

    snackPosition: isPosition?SnackPosition.BOTTOM:SnackPosition.TOP,


   // dismissDirection: SnackBar.HORIZONTAL,
  ));
}

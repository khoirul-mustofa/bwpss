import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snackbarTop(
    {required String title,
    required String message,
    required Function(SnackbarStatus?)? snackbarStatus}) {
  return Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red.withOpacity(0.7),
    colorText: Colors.white,
    borderRadius: 8,
    margin: const EdgeInsets.all(10),
    icon: const Icon(Icons.error, color: Colors.white),
    duration: const Duration(seconds: 3),
    snackbarStatus: snackbarStatus,
  );
}

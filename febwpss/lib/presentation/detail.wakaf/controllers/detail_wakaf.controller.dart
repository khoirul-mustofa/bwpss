import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/helper/snackbar.top.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailWakafController extends GetxController {
  final nameController = TextEditingController();
  final noWa = TextEditingController();
  final email = TextEditingController();
  final pesan = TextEditingController();

  int nominalPrice = 0;
  String metodePembayaran = '';
  String sapaan = '';

  CategoryWakaf? category = Get.arguments;
  final List<String> prices = ['10', '20', '50', '100', 'Nominal'];
  int? selectedIndexPrice;

  List<String> banks = ['bca', 'bni', 'bri'];
  String? selectedBank;
  onChangeIndexPrice(int index) {
    selectedIndexPrice = index;
    switch (index) {
      case 0:
        nominalPrice = 10000;
        break;
      case 1:
        nominalPrice = 20000;
        break;
      case 2:
        nominalPrice = 50000;
        break;
      case 3:
        nominalPrice = 100000;
        break;
      case 4:
        nominalPrice = 0;
        break;
    }
    update();
  }

  onChangeInputForm(p0, p1, p2, p3) {
    nameController.text = p0;
    noWa.text = p1;
    email.text = p2;
    pesan.text = p3;
    update();
  }

  bool isButtonDisabled = false;

  onHideSnackBar(val) {
    if (val == SnackbarStatus.CLOSED) {
      isButtonDisabled = false;
      update();
    }
  }

  onSubmitForm() {
    isButtonDisabled = true;
    update();
    if (nominalPrice == 0) {
      snackbarTop(
          title: 'Error',
          message: 'Nominal price cannot be zero.',
          snackbarStatus: onHideSnackBar);
    } else if (nameController.text.isEmpty) {
      snackbarTop(
          title: 'Error',
          message: 'Name cannot be empty.',
          snackbarStatus: onHideSnackBar);
    } else if (noWa.text.isEmpty) {
      snackbarTop(
          title: 'Error',
          message: 'WhatsApp number cannot be empty.',
          snackbarStatus: onHideSnackBar);
    } else if (email.text.isEmpty) {
      snackbarTop(
          title: 'Error',
          message: 'Email cannot be empty.',
          snackbarStatus: onHideSnackBar);
    } else {
      Wakaf wakaf = Wakaf(
          categoryWakaf: category?.name,
          namaLengkap: nameController.text,
          noWa: noWa.text,
          email: email.text,
          pesan: pesan.text,
          sapaan: sapaan,
          metodeBayar: metodePembayaran,
          price: nominalPrice,
          fcmToken: '');

      Get.toNamed(Routes.PAYMENT, arguments: wakaf);
    }
  }

  @override
  void onInit() {
    super.onInit();
    isButtonDisabled = false;
  }
}

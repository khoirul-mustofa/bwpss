import 'dart:convert';

import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/helper/payment.icons.dart';
import 'package:febwpss/infrastructure/dal/services/payment.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailPaymentController extends GetxController {
  PaymentService paymentService = PaymentService();
  bool isLoading = true;

  ///NOTE: wakaf & response is dumy data
  // Wakaf wakaf = Get.arguments['wakaf'];
  Wakaf wakaf = Wakaf(
    id: 1,
    namaLengkap: "Ahmad Zaki",
    sapaan: "Bapak",
    categoryWakaf: "Pembangunan Masjid",
    price: 1000000,
    noWa: "081234567890",
    email: "ahmadzaki@example.com",
    pesan: "Semoga berkah untuk semua",
    metodeBayar: "bri",
    fcmToken: "token_fcm_123",
    createdAt: "2024-10-18",
    updatedAt: "2024-10-18",
  );

  // dynamic response;

  dynamic response = {
    "status_code": "201",
    "status_message": "OK, Mandiri Bill transaction is successful",
    "transaction_id": "a005107a-636c-4af7-8095-b574f8a8e7d0",
    "order_id": "W-20241018-67127141cb1e2",
    "merchant_id": "G911205469",
    "gross_amount": "1000000.00",
    "currency": "IDR",
    "payment_type": "echannel",
    "transaction_time": "2024-10-18 21:31:33",
    "transaction_status": "pending",
    "fraud_status": "accept",
    "bill_key": "705949650571",
    "biller_code": "70012",
    "expiry_time": "2024-10-19 21:31:33"
  };

  final List<String> listVirtualAccountIcons = [
    PaymentIcons.bcaLogo,
    PaymentIcons.echannelLogo,
    PaymentIcons.bniLogo,
    PaymentIcons.briLogo,
    PaymentIcons.permataLogo,
    PaymentIcons.cimbLogo,
  ];
  String getIconBank(String bank) {
    switch (bank) {
      case 'bca':
        return PaymentIcons.bcaLogo;
      case 'bni':
        return PaymentIcons.bniLogo;
      case 'permata':
        return PaymentIcons.permataLogo;
      case 'bri':
        return PaymentIcons.briLogo;
      case 'cimb':
        return PaymentIcons.cimbLogo;
      default:
        return PaymentIcons.echannelLogo;
    }
  }

  createPayment() async {
    try {
      print(wakaf);
      response = await paymentService.createPayment({
        "amount": wakaf.price,
        "nama_lengkap": wakaf.namaLengkap,
        "email": wakaf.email,
        "phone": wakaf.noWa,
        "bank": wakaf.metodeBayar,
        "fcm_token": '',
        "sapaan": wakaf.sapaan,
        "category_wakaf": wakaf.categoryWakaf,
        "pesan": wakaf.pesan,
      }).then((response) {
        return response.data;
      });
      await Future.delayed(const Duration(seconds: 2)).then((_) {
        isLoading = false;
        update();
      });
      update();
      print('Payment created successfully => $response');
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Map<String, dynamic>> loadPaymentInstructions() async {
    String jsonString =
        await rootBundle.loadString('assets/json/payment_instructions.json');
    return jsonDecode(jsonString);
  }

  @override
  void onInit() {
    super.onInit();
    createPayment();
    if (kDebugMode) {
      isLoading = false;
    }
  }
}

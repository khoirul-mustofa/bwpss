import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/infrastructure/dal/services/payment.service.dart';
import 'package:get/get.dart';

class DetailPaymentController extends GetxController {
  PaymentService paymentService = PaymentService();

  Wakaf wakaf = Get.arguments['wakaf'];

  bool isLoading = true;

  dynamic response;

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

  @override
  void onInit() {
    super.onInit();
    createPayment();
  }
}

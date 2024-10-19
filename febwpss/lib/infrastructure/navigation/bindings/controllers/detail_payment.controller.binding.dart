import 'package:get/get.dart';

import '../../../../presentation/detail.payment/controllers/detail_payment.controller.dart';

class DetailPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPaymentController>(
      () => DetailPaymentController(),
    );
  }
}

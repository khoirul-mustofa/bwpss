import 'package:get/get.dart';

import '../../../../presentation/detail.wakaf/controllers/detail_wakaf.controller.dart';

class DetailWakafControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWakafController>(
      () => DetailWakafController(),
    );
  }
}

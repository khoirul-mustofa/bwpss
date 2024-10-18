import 'package:get/get.dart';

import '../../../../presentation/wakaf/controllers/wakaf.controller.dart';

class WakafControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WakafController>(
      () => WakafController(),
    );
  }
}

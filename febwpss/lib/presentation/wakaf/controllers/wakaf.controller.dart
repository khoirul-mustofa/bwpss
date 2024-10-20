import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/infrastructure/dal/services/wakaf.service.dart';
import 'package:get/get.dart';

class WakafController extends GetxController {
  CategoryWakaf categoryWakaf = Get.arguments;
  int totalAmount = 0;
  final WakafService _service = WakafService();
  var currentIndex = 0.obs;

  void getTotalAmount() async {
    await _service.countPriceWakafByCategory(1).then((value) {
      totalAmount = value.data['data']['total_amount'];
      update();
    });
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getTotalAmount();
  }
}

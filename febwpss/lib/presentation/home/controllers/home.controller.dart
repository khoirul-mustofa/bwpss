import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/infrastructure/dal/services/category.service.dart';
import 'package:febwpss/infrastructure/dal/services/wakaf.service.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final WakafService _wakafService = WakafService();
  final CategoryService _categoryService = CategoryService();

  var wakafs = <Wakaf>[];
  List<CategoryWakaf> categories = [];

  @override
  void onInit() {
    super.onInit();
    fetchWakafs();
    fetchCategoryWakaf();
  }

  void fetchCategoryWakaf() async {
    try {
      categories = await _categoryService.getCategories();
      update();
    } catch (e) {
      print("Error: $e");
    }
  }

  void fetchWakafs() async {
    try {
      wakafs = await _wakafService.getWakafs();
      update();
    } catch (e) {
      print("Error: $e");
    }
  }

  void updateWakaf(int id, Map<String, dynamic> data) async {
    try {
      await _wakafService.updateWakaf(id, data);
      fetchWakafs();
    } catch (e) {
      print(e);
    }
  }

  void deleteWakaf(int id) async {
    try {
      await _wakafService.deleteWakaf(id);
      fetchWakafs();
    } catch (e) {
      print(e);
    }
  }

  void addWakaf(Map<String, dynamic> data) async {
    try {
      await _wakafService.addWakaf(data);
    } catch (e) {
      print(e);
    }
  }

  void onTapWakaf(CategoryWakaf category) {
    Get.toNamed(Routes.WAKAF, arguments: category);
  }
}

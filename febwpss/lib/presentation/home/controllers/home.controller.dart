import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/infrastructure/dal/services/category.service.dart';
import 'package:febwpss/infrastructure/dal/services/wakaf.service.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CategoryService _categoryService = CategoryService();

  List<CategoryWakaf> categories = [];

  @override
  void onInit() {
    super.onInit();
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

  void onTapWakaf(CategoryWakaf category) {
    Get.toNamed(Routes.WAKAF, arguments: category);
  }
}

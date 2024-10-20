import 'dart:math';
import 'dart:ui';

import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/infrastructure/dal/services/category.service.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CategoryService _categoryService = CategoryService();

  List<CategoryWakaf> categories = [];

  List<String> menuApp = [
    'Wakaf',
    'Infaq',
    'Zakat',
    'Kalkulator',
    'Kiblat',
    'Haji',
    'Ziarah',
    'SilSilah'
  ];

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      120,
      random.nextInt(195),
      random.nextInt(100),
      random.nextInt(50),
    );
  }

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

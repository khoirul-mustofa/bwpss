import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/helper/dio.helper.dart';

class CategoryService {
  Future<List<CategoryWakaf>> getCategories() async {
    try {
      final response = await dio.get("category_wakaf");
      if (response.data['data'] is List) {
        List<CategoryWakaf> categorys = (response.data['data'] as List)
            .map((categoryWakaf) => CategoryWakaf.fromJson(categoryWakaf))
            .toList();
        return categorys;
      } else {
        throw Exception("Unexpected data format");
      }
    } catch (e) {
      throw Exception("Failed to fetch wakaf data");
    }
  }
}

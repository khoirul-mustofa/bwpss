import 'package:dio/dio.dart';
import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/helper/dio.helper.dart';

class WakafService {
  // Fungsi untuk menambahkan data wakaf ke API
  Future<Response> addWakaf(Map<String, dynamic> data) async {
    try {
      return await dio.post('wakaf', data: data);
    } catch (e) {
      throw Exception('Gagal menambahkan data wakaf: $e');
    }
  }

  // Fungsi untuk mengambil data wakaf dari API
  Future<List<Wakaf>> getWakafs() async {
    try {
      final response = await dio.get('wakaf');
      if (response.data['data'] is List) {
        List<Wakaf> wakafs = (response.data['data'] as List)
            .map((wakaf) => Wakaf.fromJson(wakaf))
            .toList();
        return wakafs;
      } else {
        throw Exception("Unexpected data format");
      }
    } catch (e) {
      throw Exception("Failed to fetch wakaf data");
    }
  }

  Future<Response> updateWakaf(int id, Map<String, dynamic> data) async {
    try {
      return await dio.put('wakaf/$id', data: data);
    } catch (e) {
      throw Exception('Gagal mengupdate data wakaf: $e');
    }
  }

  Future<Response> deleteWakaf(int id) async {
    try {
      return await dio.delete('wakaf/$id');
    } catch (e) {
      throw Exception('Gagal menghapus data wakaf: $e');
    }
  }

  Future<Response> countPriceWakafByCategory(int id) async {
    try {
      return await dio.get('/total-price-by-category/$id');
    } catch (e) {
      throw Exception('Gagal mendapatkan count price by category');
    }
  }
}

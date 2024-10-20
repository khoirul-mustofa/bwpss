import 'package:febwpss/helper/dio.helper.dart';

class PaymentService {
  Future createPayment(Map<String, dynamic> data) async {
    try {
      return await dio.post('midtrans/charge', data: data);
    } catch (e) {
      throw Exception('Gagal menambahkan data wakaf: $e');
    }
  }
}

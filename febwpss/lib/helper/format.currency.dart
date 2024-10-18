import 'package:intl/intl.dart';

String formatCurrency(dynamic amount) {
  final formatter = NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp ', decimalDigits: amount is double ? 0 : 0);

  if (amount is int || amount is double) {
    return formatter.format(amount).replaceAll(',00', '');
  } else {
    throw ArgumentError('Nilai harus berupa int atau double.');
  }
}

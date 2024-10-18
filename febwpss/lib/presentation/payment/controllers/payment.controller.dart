import 'package:febwpss/domain/core/models/wakaf.dart';
import 'package:febwpss/helper/payment.icons.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final List<String> listVirtualAccountIcons = [
    PaymentIcons.bcaLogo,
    PaymentIcons.mandiriLogo,
    PaymentIcons.bniLogo,
    PaymentIcons.briLogo,
    PaymentIcons.permataLogo,
    PaymentIcons.cmbNiagaLogo,
  ];
  final List<String> nameVirtualAccount = [
    'bca',
    'mandiri',
    'bni',
    'bri',
    'permata',
    'cimb',
  ];

  final List<String> listAlfaIcons = [
    PaymentIcons.alfamartLogo,
    PaymentIcons.alfamidiLogo,
  ];

  String selectedPyamentMethod = "";

  Wakaf wakaf = Get.arguments;

  void onTapPayMethod() {
    wakaf.metodeBayar = selectedPyamentMethod;
    Get.offNamed(Routes.DETAIL_PAYMENT, arguments: {
      'wakaf': wakaf,
    });

    print(
        'goto detail payment with method => $selectedPyamentMethod and wakaf => ${wakaf.metodeBayar}, ${wakaf.price}, goto detail payment');
  }
}

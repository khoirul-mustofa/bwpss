import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  const EnvironmentsBadge({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.WAKAF,
      page: () => const WakafScreen(),
      binding: WakafControllerBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_WAKAF,
      page: () => const DetailWakafScreen(),
      binding: DetailWakafControllerBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PaymentScreen(),
      binding: PaymentControllerBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PAYMENT,
      page: () => const DetailPaymentScreen(),
      binding: DetailPaymentControllerBinding(),
    ),
  ];
}

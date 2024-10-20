import 'package:cached_network_image/cached_network_image.dart';
import 'package:febwpss/helper/format.currency.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:febwpss/presentation/widgets/tab.bar.wakaf.dart';
import 'package:febwpss/theme/app.colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/wakaf.controller.dart';

class WakafScreen extends GetView<WakafController> {
  const WakafScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: WakafController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Wakaf'),
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: controller.categoryWakaf.image ?? '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.categoryWakaf.name ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      Text(
                        'Jombang JawaTimur',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${formatCurrency(controller.totalAmount)} ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text: 'terkumpul dari ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal)),
                        TextSpan(
                          text: formatCurrency(
                              controller.categoryWakaf.targetAmount ?? 0),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.DETAIL_WAKAF,
                            arguments: controller.categoryWakaf);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(appPrimaryColor)),
                      child: const Text(
                        'Wakaf Sekarang!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TabBarWakaf()
                ],
              ),
            ),
          );
        });
  }
}

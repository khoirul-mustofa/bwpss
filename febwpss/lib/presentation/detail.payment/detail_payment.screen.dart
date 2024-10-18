import 'package:febwpss/helper/my.logger.dart';
import 'package:febwpss/helper/payment.icons.dart';
import 'package:febwpss/presentation/widgets/payment/header.widget.dart';
import 'package:febwpss/presentation/widgets/payment/title.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controllers/detail_payment.controller.dart';

class DetailPaymentScreen extends GetView<DetailPaymentController> {
  const DetailPaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DetailPaymentController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('DetailPaymentScreen'),
              centerTitle: true,
            ),
            body: controller.isLoading == true
                ? const Center(child: CupertinoActivityIndicator())
                : Column(
                    children: [
                      HeaderWidget(
                        amount: controller.wakaf.price ?? 0,
                        orderId: controller.response?['order_id'] ?? '',
                        expiryTime: controller.response?['expiry_time'],
                      ),
                      controller.wakaf.metodeBayar == 'qris'
                          ? QrisWidget(
                              response: controller.response,
                            )
                          : const CsStoreWidget(),
                    ],
                  ),
          );
        });
  }
}

class CsStoreWidget extends StatelessWidget {
  const CsStoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              'Cara Bayar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class QrisWidget extends StatelessWidget {
  QrisWidget({
    super.key,
    required this.response,
  });

  dynamic response;
  Future<void> _launchInBrowser(Uri url) async {
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        MyLogger.error('could not found $url');
      }
    } catch (e) {
      MyLogger.fatal(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TitleWidget(
          title: 'QRIS',
          image: PaymentIcons.qrisLogo,
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            final url = response['actions'][1]['url'];
            print("Launching URL: $url");
            _launchInBrowser(Uri.parse(url));
          },
          child: SizedBox(
            width: Get.width,
            child: Center(
              child: QrImageView(
                data: response['actions'][0]['url'],
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding:
                const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            iconColor: Colors.blue,
            collapsedIconColor: Colors.blue,
            leading: const Icon(
              Icons.help_rounded,
              color: Colors.blue,
              size: 14,
            ),
            title: const Text(
              'Help to pay',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            children: [
              Card(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QRIS Payment Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('1. Open any supporting QRIS payment app.'),
                      SizedBox(height: 4.0),
                      Text('2. Download or scan QRIS on your monitor.'),
                      SizedBox(height: 4.0),
                      Text('3. Confirm payment in the app.'),
                      SizedBox(height: 4.0),
                      Text('4. Payment completed.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

import 'package:febwpss/domain/core/models/wakaf.dart';
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
              title: const Text('Detail Payment'),
              centerTitle: true,
            ),
            body: controller.isLoading == true
                ? const Center(child: CupertinoActivityIndicator())
                : SingleChildScrollView(
                    child: Column(
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
                            : CsStoreWidget(
                                controller: controller,
                              ),
                      ],
                    ),
                  ),
          );
        });
  }
}

class CsStoreWidget extends StatelessWidget {
  CsStoreWidget({super.key, required this.controller});

  DetailPaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TitleWidget(
                title: 'Bank ${controller.wakaf.metodeBayar?.toUpperCase()}',
                image:
                    controller.getIconBank(controller.wakaf.metodeBayar ?? ''),
              ),
              const SizedBox(height: 20),
              Text('messageDetailPaymentVirtualAcount'.tr),
              const SizedBox(height: 20),
              const Text(
                'Virtual account number',
                style: TextStyle(fontSize: 12),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'data',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Copy',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        FutureBuilder<Map<String, dynamic>>(
          future: controller.loadPaymentInstructions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              var data =
                  snapshot.data!['bca']; // Akses instruksi pembayaran BCA

              List<dynamic> mbcaInstructions = data['mbca'];

              return SizedBox(
                height: Get.height * 0.8,
                child: ListView(
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        childrenPadding: const EdgeInsets.only(bottom: 16),
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
                          Container(
                            height: 300,
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: ListView.builder(
                              itemCount: mbcaInstructions.length,
                              itemBuilder: (context, index) {
                                int number = index + 1;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    index == 0
                                        ? const Text('Atm BCA')
                                        : const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                          "$number. ${mbcaInstructions[index]}"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
              // _launchInBrowser(Uri.parse(url));
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
      ),
    );
  }
}

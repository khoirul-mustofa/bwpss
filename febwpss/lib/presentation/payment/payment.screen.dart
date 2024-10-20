import 'package:febwpss/helper/payment.icons.dart';
import 'package:febwpss/presentation/widgets/payment/header.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'controllers/payment.controller.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PaymentController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text('Payment Methods'),
                centerTitle: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  paymentMethods(context),
                ],
              ));
        });
  }

  ListView paymentMethods(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              title: const Text(
                'Virtual account',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: List.generate(5, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        controller.listVirtualAccountIcons[index],
                      ),
                    );
                  }),
                ),
              ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              children: [
                Wrap(
                  children: List.generate(
                      controller.listVirtualAccountIcons.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedPyamentMethod =
                            controller.nameVirtualAccount[index];
                        controller.onTapPayMethod();
                      },
                      child: Container(
                          width: Get.width * 0.45,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.only(bottom: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                controller.listVirtualAccountIcons[index],
                                width: 18,
                                height: 18,
                              ),
                            ],
                          )),
                    );
                  }),
                )
              ]),
        ),
        GestureDetector(
          onTap: () {
            controller.selectedPyamentMethod = 'qris';
            controller.onTapPayMethod();
          },
          child: ListTile(
            title: const Text(
              'QRIS',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: SvgPicture.asset(
                  PaymentIcons.qrisLogo,
                ),
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.selectedPyamentMethod = 'cstore';
            controller.onTapPayMethod();
          },
          child: ListTile(
            title: const Text(
              'Alfa Group',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children:
                    List.generate(controller.listAlfaIcons.length, (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      controller.listAlfaIcons[index],
                    ),
                  );
                }),
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ],
    );
  }
}

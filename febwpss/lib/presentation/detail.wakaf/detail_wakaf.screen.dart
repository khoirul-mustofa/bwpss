import 'package:cached_network_image/cached_network_image.dart';
import 'package:febwpss/helper/format.currency.dart';
import 'package:febwpss/presentation/widgets/form.input.wakaf.dart';
import 'package:febwpss/presentation/widgets/sapaan.form.dart';
import 'package:febwpss/theme/app.colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_wakaf.controller.dart';

class DetailWakafScreen extends GetView<DetailWakafController> {
  const DetailWakafScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailWakafController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Text(
              controller.category?.name ?? '',
            ),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  color: Colors.black.withOpacity(0.05),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: controller.category?.image ?? '',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: const Text(
                      'Anda akan berdonasi dalam program:',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    subtitle: Text(
                      controller.category?.name ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 230,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wakaf Terbaik Anda',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10, // Jarak horizontal antar item
                            mainAxisSpacing: 10, // Jarak vertikal antar item
                            childAspectRatio:
                                103 / 60, // Rasio lebar terhadap tinggi
                          ),
                          itemCount: controller.prices.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => controller.onChangeIndexPrice(index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: controller.selectedIndexPrice == index
                                      ? Border.all(
                                          width: 1,
                                          color: Colors.green.shade900)
                                      : null,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Stack(children: [
                                  index == controller.selectedIndexPrice
                                      ? Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.green.shade900,
                                            size: 16,
                                          ))
                                      : const SizedBox(),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          index == controller.prices.length - 1
                                              ? controller.prices[index]
                                              : "Rp ${controller.prices[index]}rb",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        index == controller.prices.length - 1
                                            ? const Text(
                                                'lainnya',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                controller.selectedIndexPrice == controller.prices.length - 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          onChanged: (value) {
                            controller.nominalPrice = int.tryParse(value) ?? 0;
                            controller.update();
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: 'Rp ',
                            labelText: 'Masukkan nominal',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                SapaanForm(
                  onSapaanSelected: (value) {
                    controller.sapaan = value;
                    controller.update();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FormInputWakaf(
                  onChanged: controller.onChangeInputForm,
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              width: Get.width,
              height: 50,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
              child: ElevatedButton(
                onPressed: controller.isButtonDisabled
                    ? null
                    : () async {
                        controller.onSubmitForm();
                      },
                style: ButtonStyle(
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(appPrimaryColor),
                ),
                child: Text(
                  'Wakaf - Rp ${formatCurrency(controller.nominalPrice)}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
        );
      },
    );
  }
}

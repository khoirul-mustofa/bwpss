import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:febwpss/infrastructure/navigation/routes.dart';
import 'package:febwpss/presentation/widgets/youtube.player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

const bgColor = Color.fromRGBO(43, 104, 81, 1.0);

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          if (controller.categories.isEmpty) {
            return const Scaffold(
                body: Center(child: CupertinoActivityIndicator()));
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  surfaceTintColor: Colors.white,
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      const DrawerHeader(
                        child: Column(
                          children: [
                            Icon(Icons.abc),
                          ],
                        ),
                      ),
                      const Text(
                        'Category Wakaf',
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                      // builder
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ElevatedButton.icon(
                                onPressed: () {},
                                label: Text('Category $index'),
                                icon: const Icon(Icons.abc));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: SizedBox(
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 20 / 10,
                            viewportFraction: 1,
                            autoPlay: true,
                          ),
                          items: [
                            'https://bwpt.or.id/wp-content/uploads/2022/11/bwpt-pendidkan.jpeg',
                            'https://bwpt.or.id/wp-content/uploads/2022/11/bwpt.jpeg',
                            'https://bwpt.or.id/wp-content/uploads/2022/11/Bantu-pendidikan-mereka-bersama-BWPT-1.jpeg',
                            'https://bwpt.or.id/wp-content/uploads/2022/11/bwpt-untuk-wakaf.jpeg',
                            'https://bwpt.or.id/wp-content/uploads/2023/01/toleransi-small-crop.jpg'
                          ].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return CachedNetworkImage(
                                  width: Get.width,
                                  height: 200,
                                  imageUrl: i,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const Text(
                          'BWPSS',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        const Text(
                          'Badan Wakaf Pesantren Salafiah Seblak',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // const SizedBox(
                        //     height: 230, child: YouTubePlayerScreen()),
                        // const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 30,
                          children:
                              List.generate(controller.menuApp.length, (index) {
                            return SizedBox(
                                width: 60,
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          controller.getRandomColor(),
                                      radius: 25,
                                      child: Text(
                                        controller.menuApp[index][0],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.menuApp[index],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ));
                          }),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'PROGRAM UTAMA',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(1, 0),
                                ),
                              ],
                            ),
                            child: _buildCard(context, 0, controller,
                                isUnggulan: true,
                                onTap: () => controller
                                    .onTapWakaf(controller.categories[0]))),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'PROGRAM WAKAF',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                controller.categories.length, (index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? const SizedBox()
                                      : const Divider(
                                          height: 0.5,
                                        ),
                                  _buildCard(
                                    context,
                                    index,
                                    controller,
                                    isUnggulan: false,
                                    onTap: () {
                                      Get.toNamed(Routes.WAKAF,
                                          arguments:
                                              controller.categories[index]);
                                    },
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(16),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ingin Menggalang Dana ?',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(bgColor)),
                                  onPressed: () {},
                                  child: Text(
                                    'Yuks, Galang Dana',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber.shade200,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  label: Text(
                                    'Tany Galang Dana di BWPSS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber.shade200,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(bgColor)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        kenapaWakafDIsini(bgColor)
                      ],
                    ),
                  ),
                ));
          }
        });
  }

  Container kenapaWakafDIsini(Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Kenapa Wakaf Disini?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Ada beberapa Alasan yang seharusnya anda pertimbangkan sebelum berwakaf di BWPSS',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: Get.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 40,
                      color: bgColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TERPERCAYA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: bgColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'BWPT memahami bahwa wakaf sah apabila dilaksanakan menurut syariah. Kami juga memahami bahwa wakaf bertujuan memanfaatkan harta benda wakaf sesuai dengan fungsinya untuk kemanfaatan umum. Wakaf berfungsi mewujudkan potensi dan manfaat ekonomis harta benda wakaf untuk kepentingan ibadah dan untuk memajukan kesejahteraan umum.',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index, HomeController controller,
      {bool isUnggulan = false, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: controller.categories[index].image ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.categories[index].name ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'BWPSS Badan Wakaf Pesantren Salafiah Seblak',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: const TextSpan(
                  text: 'Rp 25.000  ',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Terkumpul',
                      style: TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 0.01,
                color: Colors.green,
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 5,
              ),
              isUnggulan == true
                  ? ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.DETAIL_WAKAF,
                            arguments: controller.categories[index]);
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
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(43, 104, 81, 1.0)),
                      ),
                      child: const Text(
                        'Wakaf Sekarang',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

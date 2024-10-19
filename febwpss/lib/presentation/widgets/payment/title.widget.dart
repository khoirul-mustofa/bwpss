import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({super.key, required this.title, required this.image});

  String title;
  String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            image,
            width: 50,
          )
        ],
      ),
    );
  }
}

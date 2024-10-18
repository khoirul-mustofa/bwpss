import 'dart:async';

import 'package:febwpss/helper/format.currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatefulWidget {
  HeaderWidget(
      {super.key,
      required this.amount,
      required this.orderId,
      required this.expiryTime,
      onselectPayment});
  final int amount;
  final String orderId;
  final String expiryTime;
  bool onSelectPayment = false;
  @override
  State<HeaderWidget> createState() => _AmountHeaderState();
}

class _AmountHeaderState extends State<HeaderWidget> {
  late Timer _timer;
  late Duration _remainingTime;
  @override
  void initState() {
    super.initState();
    DateTime expiryDate =
        DateTime.parse(widget.expiryTime); // Konversi string ke DateTime
    _remainingTime = expiryDate.difference(DateTime.now()); // Hitung sisa waktu
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      } else {
        timer.cancel(); // Menghentikan timer jika waktunya habis
        // Aksi setelah waktu habis
        Get.back();
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            formatCurrency(widget.amount),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Order ID #${widget.orderId}',
                style: const TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.orderId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Teks berhasil disalin!'),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.copy,
                  size: 14,
                )),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('Details')),
          ],
        ),
        widget.onSelectPayment == false
            ? Container(
                width: Get.width,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Center(
                    child: Text(
                  formatDuration(_remainingTime),
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              )
            : const Divider(),
      ],
    );
  }
}

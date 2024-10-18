import 'package:flutter/material.dart';

class FormInputWakaf extends StatefulWidget {
  final Function(String, String, String, String) onChanged; // Callback function

  const FormInputWakaf({super.key, required this.onChanged});

  @override
  _FormInputWakafState createState() => _FormInputWakafState();
}

class _FormInputWakafState extends State<FormInputWakaf> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool hideName = false;

  void _updateFields() {
    widget.onChanged(
      hideName ? 'Hamba Allah' : nameController.text,
      whatsappController.text,
      emailController.text,
      messageController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Masukkan nama lengkap Anda',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
            ),
            enabled: !hideName,
            onChanged: (value) => _updateFields(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sembunyikan Nama saya (Hamba Allah)'),
              Switch(
                inactiveThumbColor: Colors.black,
                trackOutlineColor: const WidgetStatePropertyAll(Colors.green),
                activeColor: Colors.green,
                inactiveTrackColor: Colors.green.withOpacity(0.5),
                value: hideName,
                onChanged: (value) {
                  setState(() {
                    hideName = value;
                  });
                  _updateFields();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            controller: whatsappController,
            decoration: const InputDecoration(
              labelText: 'Nomor WhatsApp',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Masukkan nomor WhatsApp Anda',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            onChanged: (value) => _updateFields(),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Masukkan email Anda',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
            ),
            onChanged: (value) => _updateFields(),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: messageController,
            decoration: const InputDecoration(
              labelText: 'Pesan',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Masukkan pesan Anda',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
            ),
            maxLines: 3,
            onChanged: (value) => _updateFields(),
          ),
        ],
      ),
    );
  }
}

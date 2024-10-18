import 'package:flutter/material.dart';

class SapaanForm extends StatefulWidget {
  // Callback function untuk mengirimkan nilai ke luar
  final Function(String) onSapaanSelected;

  const SapaanForm({super.key, required this.onSapaanSelected});

  @override
  _SapaanFormState createState() => _SapaanFormState();
}

class _SapaanFormState extends State<SapaanForm> {
  int selectedIndex = 0;

  final List<String> sapaanOptions = ['Bapak', 'Kak', 'Ibu'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Sapaan :',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            width: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(sapaanOptions.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index; // Update pilihan yang dipilih
                  });
                  // Panggil callback dengan nilai sapaan yang dipilih
                  widget.onSapaanSelected(sapaanOptions[selectedIndex]);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 80,
                  height: 33,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: index == selectedIndex
                            ? Colors.green
                            : Colors.grey.withOpacity(0.2),
                        width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: index == selectedIndex ? Colors.green : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      sapaanOptions[index],
                      style: TextStyle(
                          color: index == selectedIndex
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

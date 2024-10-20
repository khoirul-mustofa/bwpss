import 'package:cached_network_image/cached_network_image.dart';
import 'package:febwpss/domain/core/models/category.wakaf.dart';
import 'package:febwpss/infrastructure/dal/services/category.service.dart';
import 'package:flutter/material.dart';

class ListCardWakaf extends StatefulWidget {
  const ListCardWakaf({super.key});
  @override
  State<ListCardWakaf> createState() => _ListCardWakafState();
}

class _ListCardWakafState extends State<ListCardWakaf> {
  List<CategoryWakaf> categories = [];
  final CategoryService _service = CategoryService();

  void fetchWakafs() async {
    try {
      setState(() {});
      categories = await _service.getCategories();
    } catch (e) {
      setState(() {});
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCard(context, index);
        });
  }

  Widget _buildCard(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade50,
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl:
                  "https://bwpt.or.id/wp-content/uploads/2022/10/langkah-mengurus-sertifikat-tanah-secara-gratis.jpg",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Column(
            children: [
              Text(categories[index].name ?? ''),
              const Text('BWPSS Badan Wakaf Pesantren Salafiah Seblak'),
              LinearProgressIndicator(
                value: 0.01,
                color: Colors.green,
                backgroundColor: Colors.grey.shade300,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_with_getx/controller/news_controller.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> newsDetail;
  const NewsDetailScreen({super.key, required this.newsDetail});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<NewsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                c.changeTheme();
              },
              icon: c.isTheme.value
                  ? Icon(Icons.dark_mode)
                  : Icon(Icons.light_mode),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsDetail['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),
            Text(
              newsDetail['isoDate'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),

              child: Image.network(newsDetail['image']['large']),
            ),
            SizedBox(height: 24),

            Text(
              newsDetail['contentSnippet'],
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 24),

            Text(
              newsDetail['link'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

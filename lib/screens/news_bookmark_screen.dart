import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_with_getx/controller/news_controller.dart';
import 'package:news_app_with_getx/screens/news_detail_screen.dart';

class NewsBookmarkScreen extends StatelessWidget {
  var newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Saved News')),
      body: Obx(() {
        if (newsController.bookMark.isEmpty) {
          return Center(child: Text('Saved News is empty'));
        }
        return ListView.builder(
          itemCount: newsController.bookMark.length,
          itemBuilder: (context, index) {
            final item = newsController.bookMark[index];
            return ListTile(
              leading: CircleAvatar(child: Text('1')),
              title: Text(item['title']),
              subtitle: Text(item['isoDate']),
              trailing: IconButton(
                onPressed: () {
                  newsController.removeBookMark(item);
                },
                icon: Icon(Icons.delete),
              ),
              onTap: () {
                Get.to(NewsDetailScreen(newsDetail: item));
              },
            );
          },
        );
      }),
    );
  }
}

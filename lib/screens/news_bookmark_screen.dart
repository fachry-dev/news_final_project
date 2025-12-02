import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_with_getx/controller/news_controller.dart';
import 'package:news_app_with_getx/screens/news_detail_screen.dart';

class NewsBookmarkScreen extends StatelessWidget {
  var newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actionsPadding: EdgeInsets.only(right: 10),
        title: Text('BookMarks'),
        toolbarHeight: 100,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white10, height: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bookmarked News',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.deepOrange,
                  ),
                  child: Text('0 post', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (newsController.bookMark.isEmpty) {
                  return Center(
                    child: Text(
                      "( There's No Bookmarked News )",
                      style: TextStyle(color: Colors.white38),
                    ),
                  );
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
            ),
          ],
        ),
      ),
    );
  }
}

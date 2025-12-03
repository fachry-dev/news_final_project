import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app_with_getx/controller/news_controller.dart';
import 'package:news_app_with_getx/screens/news_detail_screen.dart';

class NewsBookmarkScreen extends StatelessWidget {
  var newsController = Get.find<NewsController>();

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

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
                  child: Obx(() {
                    final totalPost = newsController.bookMark.length;
                    return Text(
                      '$totalPost post${totalPost == 1 ? '' : 's'}',
                      style: TextStyle(color: Colors.white),
                    );
                  }),
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
                return ListView.separated(
                  itemCount: newsController.bookMark.length,
                  itemBuilder: (context, index) {
                    final item = newsController.bookMark[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(NewsDetailScreen(newsDetail: item));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff1B1D22),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x2020200D),
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(item['image']['small']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                width: 260,
                                height: 120,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['title'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.white30,
                                        ),
                                        SizedBox(width: 10),

                                        Text(
                                          formatDate(item['isoDate']),
                                          style: TextStyle(
                                            color: Colors.white30,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // ListTile(
                    //   leading: CircleAvatar(child: Text('1')),
                    //   title: Text(item['title']),
                    //   subtitle: Text(item['isoDate']),
                    //   trailing: IconButton(
                    //     onPressed: () {
                    //       newsController.removeBookMark(item);
                    //     },
                    //     icon: Icon(Icons.delete),
                    //   ),
                    //   onTap: () {
                    //     Get.to(NewsDetailScreen(newsDetail: item));
                    //   },
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20);
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

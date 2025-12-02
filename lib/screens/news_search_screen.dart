import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_getx/controller/news_controller.dart';
import 'package:news_app_with_getx/screens/news_bookmark_screen.dart';
import 'package:news_app_with_getx/screens/news_detail_screen.dart';

class NewsSearchScreen extends StatelessWidget {
  const NewsSearchScreen({super.key});

  Widget categoryButton(String label, String type) {
    final newsController = Get.find<NewsController>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: newsController.selectedCategory.value == type
            ? Colors.white
            : Color(0xff1B1D22),
        foregroundColor: newsController.selectedCategory.value == type
            ? Color(0xff1B1D22)
            : Colors.white,
        textStyle: TextStyle(
          fontWeight: newsController.selectedCategory.value == type
              ? FontWeight.w800
              : FontWeight.w400,
        ),
        elevation: newsController.selectedCategory.value == type ? 0 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: () {
        newsController.changeCategory(type);
      },
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();
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
        title: Text(
          'Kabari',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(NewsBookmarkScreen());
            },
            icon: Icon(Icons.bookmarks_outlined, color: Colors.white),
          ),
          // Obx(
          //   () => IconButton(
          //     onPressed: () {
          //       newsController.changeTheme();
          //     },
          //     icon: newsController.isTheme.value
          //         ? Icon(Icons.dark_mode)
          //         : Icon(Icons.light_mode),
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
            child: TextField(
              controller: newsController.searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search News...',
                hintStyle: TextStyle(color: Colors.white38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Obx(() {
                return Row(
                  spacing: 10,
                  children: [
                    categoryButton('Semua', 'semua'),
                    categoryButton('National', 'nasional'),
                    categoryButton('International', 'internasional'),
                    categoryButton('Ekonomi', 'ekonomi'),
                    categoryButton('Olahraga', 'olahraga'),
                    categoryButton('Teknologi', 'teknologi'),
                    categoryButton('Hiburan', 'hiburan'),
                    categoryButton('Gaya-hidup', 'gaya-hidup'),
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              final listToDisplay = newsController.filteredNews;
              if (newsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (listToDisplay.isEmpty) {
                return Center(child: Text('no news found'));
              }

              return ListView.separated(
                itemCount: listToDisplay.length,
                itemBuilder: (context, index) {
                  final item = listToDisplay[index];
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
                              height: 160,
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
                            SizedBox(width: 20),
                            Container(
                              width: 260,
                              height: 160,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['title'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item['isoDate'],
                                    style: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Obx(() {
                                final isBookMarked = newsController.isBookMark(
                                  item,
                                );
                                return IconButton(
                                  onPressed: () {
                                    if (isBookMarked) {
                                      newsController.removeBookMark(item);
                                    } else {
                                      newsController.addBookMark(item);
                                    }
                                  },
                                  icon: isBookMarked
                                      ? Icon(Icons.bookmark_rounded)
                                      : Icon(Icons.bookmark_border_rounded),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

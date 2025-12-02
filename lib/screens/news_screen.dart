import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_getx/controller/news_controller.dart';
import 'package:news_app_with_getx/screens/news_detail_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  Widget categoryButton(String label, String type) {
    final newsController = Get.find<NewsController>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: newsController.selectedCategory.value == type
            ? Colors.redAccent
            : newsController.isTheme.value
            ? Colors.grey[800]
            : Colors.white,
        // The foreground color also depends on the controller's state.
        foregroundColor: newsController.selectedCategory.value == type
            ? Colors.white
            : newsController.isTheme.value
            ? Colors.white
            : Colors.redAccent,
        textStyle: TextStyle(
          fontWeight: newsController.selectedCategory.value == type
              ? FontWeight.w800
              : FontWeight.w400,
        ),
        elevation: newsController.selectedCategory.value == type ? 0 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'World',
                style: TextStyle(
                  color: newsController.isTheme.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'Buz',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 100,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                newsController.changeTheme();
              },
              icon: newsController.isTheme.value
                  ? Icon(Icons.dark_mode)
                  : Icon(Icons.light_mode),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
            child: TextField(
              controller: newsController.searchController,
              decoration: InputDecoration(
                hintText: 'Search News...',
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
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: newsController.isTheme.value
                              ? Colors.grey[900]
                              : Colors.white,
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
                              width: 110,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(item['image']['small']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 220,
                              height: 120,
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
                                        color: newsController.isTheme.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item['isoDate'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
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

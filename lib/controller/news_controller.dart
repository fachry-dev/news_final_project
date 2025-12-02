import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  var url = 'https://berita-indo-api.vercel.app/v1/cnn-news/'.obs;
  var isTheme = false.obs;
  final searchController = TextEditingController();
  var selectedCategory = 'semua'.obs;

  final allNews = <Map<String, dynamic>>[].obs;
  final filteredNews = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> getNews() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url.value));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final jsonList = json['data'] as List;
        allNews.value = jsonList.map((e) => e as Map<String, dynamic>).toList();
        filteredNews.value = allNews.toList();
      } else {
        throw Exception('failed to load news');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;

    if (category == 'semua') {
      url.value = 'https://berita-indo-api.vercel.app/v1/cnn-news/';
    } else {
      url.value = 'https://berita-indo-api.vercel.app/v1/cnn-news/$category';
    }
    getNews();
  }

  void applySearch(String query) {
    if (query.isEmpty) {
      filteredNews.value = allNews.toList();
    } else {
      filteredNews.value = allNews.where((type) {
        return type['title'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void changeTheme() {
    isTheme.value = !isTheme.value;
    if (isTheme.value) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNews();
    searchController.addListener(() {
      applySearch(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

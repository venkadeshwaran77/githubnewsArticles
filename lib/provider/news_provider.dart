import 'package:flutter/material.dart';
import 'package:news_articles/models/news_model.dart';
import 'package:news_articles/services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<List<NewsModel>> fetchAllNews({
    required int pageIndex,
    required String sortBy,
  }) async {
    newsList = await NewsApiServices.getAllNews(
      page: pageIndex,
      sortBy: sortBy,
    );
    return newsList;
  }

  NewsModel findByDate({required String publishedAt}) {
    return newsList.firstWhere(
      (newsModel) => newsModel.publishedAt == publishedAt,
    );
  }
}

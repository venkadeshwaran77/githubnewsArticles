import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_articles/const/api_const.dart';
import 'package:news_articles/models/bookmarks_model.dart';
import 'package:news_articles/models/news_model.dart';
import 'package:news_articles/services/news_api.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookmarkList = [];

  List<BookmarksModel> get getNewsList {
    return bookmarkList;
  }

  Future<List<BookmarksModel>> fetchBookmarks() async {
    bookmarkList = await NewsApiServices.getBookmarks() ?? [];
    //notifyListeners();
    return bookmarkList;
  }

  Future<void> addToBookmark({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.post(
        uri,
        body: json.encode(newsModel.toJson()),
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (error) {
      rethrow;
    }
  }

 /* Future<void> deleteBookmark() async {
    try {
    var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.delete(uri);

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (error) {
      rethrow;
    }
  }*/
} 

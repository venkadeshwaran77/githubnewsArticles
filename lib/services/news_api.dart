import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:news_articles/const/api_const.dart';
import 'package:news_articles/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApiServices {
  static Future<List<NewsModel>> getAllNews({
    required int page,
    required String sortBy,
  }) async {
    //var url = Uri.parse(
    //'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=');
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "apple",
        "pageSize": "5",
        "domains": "techcrunch.com,then",
        "page": page.toString(),
        "sortBy": sortBy,
        // "apiKEY" : API_KEY
      });
      var response = await http.get(uri, headers: {"X-Api-key": API_KEY});
      log('Response status: ${response.statusCode}');
      //log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message5'];
      }
      for (var v in data['articles']) {
        newsTempList.add(v);
        // log(v.toString());
        //print(data['articles'].length.toString());
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
  static Future<List<NewsModel>> getTopHeadlines(
  
  ) async {
    //var url = Uri.parse(
    //'https://newsapi.org/v2/top-headlines?country=us&apiKey=');
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
        'country':'us'

        // "apiKEY" : API_KEY
      });
      var response = await http.get(
        uri, 
        headers: {"X-Api-key": API_KEY}
        );
      log('Response status: ${response.statusCode}');
      //log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message5'];
      }
      for (var v in data['articles']) {
        newsTempList.add(v);
        // log(v.toString());
        //print(data['articles'].length.toString());
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
   static Future<List<NewsModel>> searchNews({
    
    required String query,
  }) async {
    
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "techcrunch.com,then",
      });
      var response = await http.get(uri, headers: {"X-Api-key": API_KEY});
      log('Response status: ${response.statusCode}');
      //log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message5'];
      }
      for (var v in data['articles']) {
        newsTempList.add(v);
        // log(v.toString());
        //print(data['articles'].length.toString());
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}

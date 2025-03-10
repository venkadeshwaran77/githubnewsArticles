import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_articles/articles_model.dart';

Future<List<Article>> fetchNews() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=6c88440fcfe74eafa7fb6177b35505b9'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> articlesJson = data['articles'];
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}
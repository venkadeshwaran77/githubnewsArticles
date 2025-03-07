import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = 'YOUR_NEWS_API_KEY';
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=';

  Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_keys.dart';
import '../models/article.dart';

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<Article>> fetchTopHeadlines(String category) async {
    String apiCategory = category.toLowerCase();
    if (apiCategory == 'cinema') {
      apiCategory = 'entertainment';
    }
    if (apiCategory == 'tech') {
      apiCategory = 'technology';
    }

    final Uri url = Uri.parse('$_baseUrl?country=us&category=$apiCategory&apiKey=$newsApiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List<dynamic> articlesJson = data['articles'] as List<dynamic>;
          return articlesJson
              .map((json) => Article.fromJson(json as Map<String, dynamic>))
              .where((article) => article.title.isNotEmpty && article.url.isNotEmpty)
              .toList();
        } else {
          throw Exception(data['message'] ?? 'Failed to load news');
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to load news (HTTP ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

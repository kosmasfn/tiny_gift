import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteDataSource {
  Future<String> authenticateUser(String username, String password);
  Future<NewsResponse> fetchNews();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<String> authenticateUser(String username, String password) async {
    // Simulating network call
    await Future.delayed(Duration(seconds: 2));
    // return "token123";  // Return a token if successful
    return username;  // Return a token if successful
  }
  
  @override
  Future<NewsResponse> fetchNews() async {
    final url = 'https://newsapi.org/v2/everything?q=tesla&from=2025-01-14&sortBy=publishedAt&apiKey=7ae3938bb8ad403da302f65af4ec5256';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news');
    }
  }

}

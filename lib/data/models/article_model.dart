import 'dart:convert';

class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? publishedAt;
  final String? urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage'],
    );
  }
}

class NewsResponse {
  final List<Article> articles;

  NewsResponse({required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<Article> articlesList = list.map((i) => Article.fromJson(i)).toList();

    return NewsResponse(articles: articlesList);
  }
}

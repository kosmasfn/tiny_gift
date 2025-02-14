import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiny_gift/domain/usecases/news_usecase.dart';
import 'package:tiny_gift/view/providers/news_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});

  final String title;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsProvider);  // Watch the newsProvider

    return Scaffold(
      // appBar: AppBar(title: Text('News')),
      body: newsState.when(
        data: (newsResponse) {
          return ListView.builder(
            itemCount: newsResponse.articles.length,
            itemBuilder: (context, index) {
              final article = newsResponse.articles[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  leading: Image.network(article.urlToImage ?? ""),  // Display image from URL
                  title: Text(article.title ?? ""),
                  subtitle: Text(article.description ?? 'No description'),
                  onTap: () {
                    // You can add a navigation logic here to open article URLs
                    // print('Open article: ${article.url}');
                  },
                ), 
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

import 'package:tiny_gift/data/models/article_model.dart';
import 'package:tiny_gift/data/repositories/news_repository_impl.dart';
import 'package:tiny_gift/domain/repositories/usecase_without_params.dart';

class NewsUseCase extends UseCaseNoParams<NewsResponse> {
  final NewsRepository repository;

  NewsUseCase(this.repository);
  
  @override
  Future<NewsResponse> call() {
    return repository.fetchNews();
  }
}

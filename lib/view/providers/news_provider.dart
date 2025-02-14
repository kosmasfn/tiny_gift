import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiny_gift/data/datasources/remote_data_source.dart.dart';
import 'package:tiny_gift/data/models/article_model.dart';
import 'package:tiny_gift/data/repositories/news_repository_impl.dart';
import 'package:tiny_gift/domain/usecases/news_usecase.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSourceImpl();  // Create and provide UserRepository instance
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final dataSource = ref.watch(remoteDataSourceProvider);  // Access UserRepository from the provider
  return NewsRepositoryImpl(remoteDataSource: dataSource);  // Create and provide UserRepository instance
});

final newsUseCaseProvider = Provider<NewsUseCase>((ref) {
  final repository = ref.watch(newsRepositoryProvider);  // Access UserRepository from the provider
  return NewsUseCase(repository);  // Create and provide NewsUseCase instance
});

final newsProvider = FutureProvider<NewsResponse>((ref) async {
  final newsUseCase = ref.watch(newsUseCaseProvider);  // Access NewsUseCase from the provider
  return newsUseCase.call();  // Call NewsUseCase to fetch data
});

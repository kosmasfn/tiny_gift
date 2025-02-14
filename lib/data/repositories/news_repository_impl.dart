import 'package:tiny_gift/data/datasources/remote_data_source.dart.dart';

import '../models/article_model.dart';

abstract class NewsRepository {
  Future<NewsResponse> fetchNews();
}

class NewsRepositoryImpl implements NewsRepository {
  final RemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<NewsResponse> fetchNews() async {
    return await remoteDataSource.fetchNews();
  }
}

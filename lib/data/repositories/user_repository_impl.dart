import 'package:tiny_gift/data/datasources/remote_data_source.dart.dart';

abstract class UserRepository {
  Future<String> authenticate(String username, String password);
}

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> authenticate(String username, String password) async {
    return await remoteDataSource.authenticateUser(username, password);
  }
}

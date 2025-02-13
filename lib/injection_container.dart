import 'package:get_it/get_it.dart';
import 'package:tiny_gift/data/datasources/remote_data_source.dart.dart';
import 'package:tiny_gift/data/repositories/user_repository_impl.dart';
import 'package:tiny_gift/domain/usecases/authenticate_user.dart';
import 'package:tiny_gift/view/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(() => AuthBloc(authenticateUser: sl()));

  // Use Cases
  sl.registerLazySingleton(() => AuthenticateUser(sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
}

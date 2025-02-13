import 'package:tiny_gift/core/usecases/usecase.dart';
import 'package:tiny_gift/data/repositories/user_repository_impl.dart';

class AuthenticateUser extends UseCase<String, AuthParams> {
  final UserRepository repository;

  AuthenticateUser(this.repository);

  @override
  Future<String> call(AuthParams params) {
    return repository.authenticate(params.username, params.password);
  }
}

class AuthParams {
  final String username;
  final String password;

  AuthParams({required this.username, required this.password});
}

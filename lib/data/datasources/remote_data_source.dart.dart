abstract class RemoteDataSource {
  Future<String> authenticateUser(String username, String password);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<String> authenticateUser(String username, String password) async {
    // Simulating network call
    await Future.delayed(Duration(seconds: 2));
    // return "token123";  // Return a token if successful
    return username;  // Return a token if successful
  }
}

abstract interface class AuthRemoteDataSource {
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<String> logIn({required String email, required String password});
}

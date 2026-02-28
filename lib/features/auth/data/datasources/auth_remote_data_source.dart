import 'package:clean_architecture_project/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logIn({required String email, required String password});
}

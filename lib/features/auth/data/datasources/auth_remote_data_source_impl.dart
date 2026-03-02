import 'package:clean_architecture_project/core/helpers/exceptions.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_project/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  @override
  get currentUserSession => supabaseClient.auth.currentSession;

  AuthRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerExceptions('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerExceptions('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final session = currentUserSession;
      if (session == null) return null;

      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', session.user.id);

      if (userData.isEmpty) return null;

      return UserModel.fromJson(
        userData.first,
      ).copyWith(email: session.user.email);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}

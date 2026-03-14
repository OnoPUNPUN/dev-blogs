import 'package:clean_architecture_project/core/helpers/exceptions.dart';
import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/core/network/connection_checker.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_project/core/common/entities/user.dart';
import 'package:clean_architecture_project/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionChecker connectionChecker;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async =>
          await remoteDataSource.logIn(email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final online = await connectionChecker.isConnected;
      if (!online) {
        return left(Failure('No Internet Connection'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          UserModel(
            email: session.user.email ?? '',
            id: session.user.id,
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User Not logged In!'));
      }

      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}

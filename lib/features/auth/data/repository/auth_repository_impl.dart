import 'package:clean_architecture_project/core/helpers/exceptions.dart';
import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_project/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  }) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}

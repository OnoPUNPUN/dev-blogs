import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  });
}

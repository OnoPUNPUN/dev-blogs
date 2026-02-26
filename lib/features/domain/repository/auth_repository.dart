import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> logIn({
    required String email,
    required String password,
  });
}

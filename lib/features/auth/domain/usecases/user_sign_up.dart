import 'package:fpdart/fpdart.dart';

import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/core/usecase/usecase.dart';
import 'package:clean_architecture_project/core/common/entities/user.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}

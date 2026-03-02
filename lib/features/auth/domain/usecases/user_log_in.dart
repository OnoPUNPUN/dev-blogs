import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/core/usecase/usecase.dart';
import 'package:clean_architecture_project/core/common/entities/user.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.logIn(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}

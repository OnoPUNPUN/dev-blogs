import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/core/usecase/usecase.dart';
import 'package:clean_architecture_project/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

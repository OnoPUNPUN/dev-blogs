part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class AppUserInitialState extends AppUserState {}

final class AppUserLoggedInState extends AppUserState {
  final User user;
  const AppUserLoggedInState(this.user);

  @override
  List<Object> get props => [user];
}

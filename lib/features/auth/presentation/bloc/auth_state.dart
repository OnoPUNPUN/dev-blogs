part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccesState extends AuthState {
  final User user;
  const AuthSuccesState(this.user);
}

final class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState(this.message);
}

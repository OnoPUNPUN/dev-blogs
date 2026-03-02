import 'package:clean_architecture_project/core/usecase/usecase.dart';
import 'package:clean_architecture_project/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/current_user.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_log_in.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogin,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignUp,
       _userLogIn = userLogin,
       _currentUser = currentUser,
       super(AuthInitialState()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(NoParams());

    response.fold((failure) => AuthFailureState(failure.message), (success) {
      print(success.email);
      return AuthSuccesState(success);
    });
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccesState(user)),
    );
  }

  void _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final res = await _userLogIn(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccesState(user)),
    );
  }
}

import 'package:clean_architecture_project/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_log_in.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;

  AuthBloc({required UserSignUp userSignUp, required UserLogIn userLogin})
    : _userSignUp = userSignUp,
      _userLogIn = userLogin,
      super(AuthInitialState()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
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

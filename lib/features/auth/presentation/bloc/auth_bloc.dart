import 'package:clean_architecture_project/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_architecture_project/core/usecase/usecase.dart';
import 'package:clean_architecture_project/core/common/entities/user.dart';
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
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogIn = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitialState()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(NoParams());

    response.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emiteAuthSuccess(user, emit),
    );
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
      (user) => _emiteAuthSuccess(user, emit),
    );
  }

  void _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final res = await _userLogIn(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emiteAuthSuccess(user, emit),
    );
  }

  void _emiteAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccesState(user));
  }
}

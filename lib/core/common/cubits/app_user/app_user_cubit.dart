import 'package:clean_architecture_project/core/common/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitialState());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitialState());
    } else {
      emit(AppUserLoggedInState(user));
    }
  }
}

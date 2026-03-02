import 'package:clean_architecture_project/core/secrets/app_secrets.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:clean_architecture_project/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/current_user.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_log_in.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviLocatore = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  if (!serviLocatore.isRegistered<SupabaseClient>()) {
    final supbase = await Supabase.initialize(
      url: AppSecrets.subaseUrl,
      anonKey: AppSecrets.subaseKey,
    );
    serviLocatore.registerLazySingleton<SupabaseClient>(() => supbase.client);
  }
}

void _initAuth() {
  serviLocatore.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviLocatore()),
  );

  serviLocatore.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviLocatore()),
  );

  // Use Case
  serviLocatore.registerFactory(() => UserSignUp(serviLocatore()));

  serviLocatore.registerFactory(() => UserLogIn(serviLocatore()));

  serviLocatore.registerFactory(() => CurrentUser(serviLocatore()));

  // Bloc
  if (!serviLocatore.isRegistered<AuthBloc>()) {
    serviLocatore.registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviLocatore(),
        userLogin: serviLocatore(),
        currentUser: serviLocatore(),
      ),
    );
  }
}

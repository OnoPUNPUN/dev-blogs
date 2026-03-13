import 'package:clean_architecture_project/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_architecture_project/core/network/connection_checker.dart';
import 'package:clean_architecture_project/core/secrets/app_secrets.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_project/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:clean_architecture_project/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_architecture_project/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/current_user.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_log_in.dart';
import 'package:clean_architecture_project/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_local_database.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_local_data_source_impl.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_remote_data_source_impl.dart';
import 'package:clean_architecture_project/features/blog/data/repository/blog_repository_impl.dart';
import 'package:clean_architecture_project/features/blog/domain/repository/blog_repository.dart';
import 'package:clean_architecture_project/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:clean_architecture_project/features/blog/domain/usecases/upload_blog.dart';
import 'package:clean_architecture_project/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviLocatore = GetIt.instance;

Future<void> initDependency() async {
  if (!serviLocatore.isRegistered<SupabaseClient>()) {
    final supbase = await Supabase.initialize(
      url: AppSecrets.subaseUrl,
      anonKey: AppSecrets.subaseKey,
    );
    serviLocatore.registerLazySingleton<SupabaseClient>(() => supbase.client);
  }

  serviLocatore.registerFactory(() => InternetConnection());

  //  core
  serviLocatore.registerLazySingleton(() => AppUserCubit());

  serviLocatore.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviLocatore()),
  );

  if (!serviLocatore.isRegistered<Database>()) {
    final database = await BlogLocalDatabase.initialize();
    serviLocatore.registerLazySingleton<Database>(() => database);
  }

  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviLocatore.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviLocatore()),
  );

  serviLocatore.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviLocatore(), serviLocatore()),
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
        appUserCubit: serviLocatore(),
      ),
    );
  }
}

void _initBlog() {
  // Datasrouce
  serviLocatore
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(database: serviLocatore()),
    )
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviLocatore()),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviLocatore(),
        blogLocalDataSource: serviLocatore(),
        connectionChecker: serviLocatore(),
      ),
    )
    // UseCase
    ..registerFactory(() => UploadBlog(blogRepository: serviLocatore()))
    ..registerFactory(() => GetAllBlogs(serviLocatore()))
    // BlogBLoc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlog: serviLocatore(), getAllBlogs: serviLocatore()),
    );
}

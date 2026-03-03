import 'package:clean_architecture_project/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_architecture_project/core/theme/theme.dart';
import 'package:clean_architecture_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_project/features/auth/presentation/pages/login_screen.dart';
import 'package:clean_architecture_project/features/blog/presentation/pages/blog_page.dart';
import 'package:clean_architecture_project/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviLocatore<AuthBloc>()),
        BlocProvider.value(value: serviLocatore<AppUserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedInState;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

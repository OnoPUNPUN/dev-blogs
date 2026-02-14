import 'package:clean_architecture_project/core/theme/theme.dart';
import 'package:clean_architecture_project/features/auth/presentation/pages/login_screen.dart';
import 'package:clean_architecture_project/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginScreen(),
    );
  }
}

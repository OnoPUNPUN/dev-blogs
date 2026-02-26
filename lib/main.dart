import 'package:clean_architecture_project/core/secrets/app_secrets.dart';
import 'package:clean_architecture_project/core/theme/theme.dart';
import 'package:clean_architecture_project/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.subaseUrl,
    anonKey: AppSecrets.subaseKey,
  );
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

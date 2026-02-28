import 'package:clean_architecture_project/core/common/widgets/loader.dart';
import 'package:clean_architecture_project/core/utils/show_snackbar.dart';
import 'package:clean_architecture_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_project/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const LoginScreen());
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Loader();
            }
            return Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 50, fontWeight: .bold),
                  ),
                  const Gap(30),
                  AuthField(hintText: 'Email', controller: _emailTEController),
                  const Gap(16),
                  AuthField(
                    hintText: 'Passwrod',
                    controller: _passwordTEController,
                  ),
                  const Gap(24),
                  AuthGradientButton(
                    text: 'Sign In.',
                    buttonColor: Colors.white,
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogIn(
                            email: _emailTEController.text.trim(),
                            password: _passwordTEController.text,
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(16),
                  AuthNotes(
                    onPressed: () =>
                        Navigator.push(context, SignUpScreen.route()),
                    normalText: 'Don\'t have an account? ',
                    text: 'Sign Up',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

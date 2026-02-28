import 'package:clean_architecture_project/core/common/widgets/loader.dart';
import 'package:clean_architecture_project/core/utils/show_snackbar.dart';
import 'package:clean_architecture_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_project/features/auth/presentation/pages/login_screen.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const SignUpScreen());
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _nameTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Sign Up',
                    style: TextStyle(fontSize: 50, fontWeight: .bold),
                  ),
                  const Gap(30),
                  AuthField(hintText: 'Email', controller: _emailTEController),
                  const Gap(16),
                  AuthField(hintText: 'Name', controller: _nameTEController),
                  const Gap(16),
                  AuthField(
                    hintText: 'Passwrod',
                    controller: _passwordTEController,
                  ),
                  const Gap(24),
                  AuthGradientButton(
                    text: 'Sign Up.',
                    buttonColor: Colors.white,
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: _emailTEController.text.trim(),
                            password: _passwordTEController.text,
                            name: _nameTEController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(16),
                  AuthNotes(
                    onPressed: () =>
                        Navigator.push(context, LoginScreen.route()),
                    normalText: 'Already Have an Account? ',
                    text: 'Sign In',
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
    _nameTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

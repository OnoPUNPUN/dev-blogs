import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_architecture_project/features/auth/presentation/widgets/auth_notes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _phoneTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
              AuthField(hintText: 'Phone', controller: _phoneTEController),
              const Gap(16),
              AuthField(
                hintText: 'Passwrod',
                controller: _passwordTEController,
              ),
              const Gap(24),
              const AuthGradientButton(
                text: 'Sign Up',
                buttonColor: Colors.white,
              ),
              const Gap(16),
              const AuthNotes(
                normalText: 'Already Have an Account? ',
                text: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

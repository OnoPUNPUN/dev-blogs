import 'package:clean_architecture_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthNotes extends StatelessWidget {
  final String normalText;
  final String text;
  const AuthNotes({super.key, required this.normalText, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: normalText,
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(
            text: text,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppPallete.gradient2),
          ),
        ],
      ),
    );
  }
}

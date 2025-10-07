import 'package:flutter/material.dart';

class PromptHeader extends StatelessWidget {
  const PromptHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter a prompt to generate an image',
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}

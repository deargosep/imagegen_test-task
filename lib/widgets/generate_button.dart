import 'package:flutter/material.dart';

class GenerateButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const GenerateButton({super.key, required this.isEnabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      child: const Text('Generate'),
    );
  }
}

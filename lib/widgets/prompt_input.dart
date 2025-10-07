import 'package:flutter/material.dart';

class PromptInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const PromptInput({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 3,
      maxLines: 5,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'e.g., A cat sitting on a rainbow',
        border: OutlineInputBorder(),
      ),
    );
  }
}

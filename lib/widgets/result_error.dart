import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../result_bloc.dart';

class ResultErrorWidget extends StatelessWidget {
  final String errorMessage;
  final String prompt;

  const ResultErrorWidget({super.key, required this.errorMessage, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 64),
        const SizedBox(height: 16),
        Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<ResultBloc>().add(GenerateImage(prompt)),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              child: const Text('Retry'),
            ),
            const SizedBox(width: 16),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('New Prompt')),
          ],
        ),
      ],
    );
  }
}

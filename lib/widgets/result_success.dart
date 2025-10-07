import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../result_bloc.dart';
import '../image_loader.dart';

class ResultSuccessWidget extends StatelessWidget {
  final String imageUrl;
  final String prompt;
  final ImageProvider? imageProvider;

  const ResultSuccessWidget({super.key, required this.imageUrl, required this.prompt, this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: imageProvider != null
              ? Image(
                  image: imageProvider!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const ImageLoader();
                  },
                )
              : Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const ImageLoader();
                  },
                ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<ResultBloc>().add(GenerateImage(prompt)),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              child: const Text('Try Another'),
            ),
            const SizedBox(width: 16),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('New Prompt')),
          ],
        ),
      ],
    );
  }
}

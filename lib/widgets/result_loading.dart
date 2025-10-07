import 'package:flutter/material.dart';
import '../image_loader.dart';

class ResultLoadingWidget extends StatelessWidget {
  const ResultLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: const ImageLoader(),
        ),
        const SizedBox(height: 32),
        const SizedBox(height: 48),
      ],
    );
  }
}

import 'dart:async';
import 'dart:math';

class MockApi {
  Future<String> generate(String prompt) async {
    await Future.delayed(Duration(seconds: Random().nextInt(2) + 2));

    if (Random().nextBool()) {
      throw Exception('Failed to generate image. Please try again.');
    }

    return 'https://picsum.photos/500/500?random=${Random().nextInt(100)}';
  }
}

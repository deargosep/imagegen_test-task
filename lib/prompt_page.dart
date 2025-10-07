import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'prompt_bloc.dart';
import 'widgets/prompt_header.dart';
import 'widgets/prompt_input.dart';
import 'widgets/generate_button.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Generator')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PromptHeader(),
              const SizedBox(height: 32),
              PromptInput(
                controller: _controller,
                onChanged: (text) => context
                    .read<PromptBloc>()
                    .add(PromptTextChanged(text)),
              ),
              const SizedBox(height: 20),
              BlocBuilder<PromptBloc, PromptState>(
                builder: (context, state) {
                  return GenerateButton(
                    isEnabled: state.isButtonEnabled,
                    onPressed: () => context.push('/result', extra: _controller.text),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

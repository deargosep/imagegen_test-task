import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'result_bloc.dart';
import 'widgets/result_loading.dart';
import 'widgets/result_success.dart';
import 'widgets/result_error.dart';

class ResultPage extends StatefulWidget {
  final String generatedText;

  const ResultPage({super.key, required this.generatedText});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    context.read<ResultBloc>().add(GenerateImage(widget.generatedText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generated Image')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<ResultBloc, ResultState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildContent(context, state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ResultState state) {
    if (state is ResultLoading) {
      return ResultLoadingWidget(key: const ValueKey('loading'));
    } else if (state is ResultSuccess) {
      return ResultSuccessWidget(
        key: const ValueKey('success'),
        imageUrl: state.imageUrl,
        prompt: widget.generatedText,
      );
    } else if (state is ResultError) {
      return ResultErrorWidget(
        key: const ValueKey('error'),
        errorMessage: state.errorMessage,
        prompt: widget.generatedText,
      );
    } else {
      return const SizedBox.shrink(key: ValueKey('initial'));
    }
  }
}

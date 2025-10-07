import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PromptEvent {}

class PromptTextChanged extends PromptEvent {
  final String text;

  PromptTextChanged(this.text);
}

class PromptState {
  final bool isButtonEnabled;

  PromptState({this.isButtonEnabled = false});
}

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptState()) {
    on<PromptTextChanged>((event, emit) {
      emit(PromptState(isButtonEnabled: event.text.trim().isNotEmpty));
    });
  }
}

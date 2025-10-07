import 'package:flutter_bloc/flutter_bloc.dart';
import 'mock_api.dart';

abstract class ResultEvent {}

class GenerateImage extends ResultEvent {
  final String prompt;

  GenerateImage(this.prompt);
}

abstract class ResultState {}

class ResultLoading extends ResultState {}

class ResultSuccess extends ResultState {
  final String imageUrl;

  ResultSuccess(this.imageUrl);
}

class ResultError extends ResultState {
  final String errorMessage;

  ResultError(this.errorMessage);
}

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final MockApi _mockApi = MockApi();

  ResultBloc() : super(ResultLoading()) {
    on<GenerateImage>((event, emit) async {
      emit(ResultLoading());
      try {
        final imageUrl = await _mockApi.generate(event.prompt);
        emit(ResultSuccess(imageUrl));
      } catch (e) {
        emit(ResultError(e.toString()));
      }
    });
  }
}

import 'package:bahaso_test/core/usecase/usecase.dart';
import 'package:bahaso_test/features/home/data/models/quiz_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result/result.dart';
import '../../../domain/usecases/get_quiz_usecase.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuizUseCase _getQuiz;
  QuizBloc({
    required GetQuizUseCase getQuiz,
  })  : _getQuiz = getQuiz,
        super(QuizInitial()) {
    on<QuizEvent>((event, emit) => emit(QuizLoading()));
    on<QuizLoaded>(_onQuizLoaded);
  }
  void _onQuizLoaded(
    QuizLoaded event,
    Emitter<QuizState> emit,
  ) async {
    final res = await _getQuiz(NoParams());
    return switch (res) {
      Success<QuizModel>(value: final data) => emit(QuizSuccess(data)),
      Failed<QuizModel>(message: final m) => emit(QuizFailure(m)),
    };
  }
}

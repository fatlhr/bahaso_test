part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoading extends QuizState {}

final class QuizSuccess extends QuizState {
  final QuizModel data;
  QuizSuccess(this.data);
}

final class QuizFailure extends QuizState {
  final String message;
  QuizFailure(this.message);
}

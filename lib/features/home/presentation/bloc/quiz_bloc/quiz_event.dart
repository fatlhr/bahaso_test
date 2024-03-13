part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}

final class QuizLoaded extends QuizEvent {}

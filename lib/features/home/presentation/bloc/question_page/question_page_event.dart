part of 'question_page_bloc.dart';

@immutable
sealed class QuestionPageEvent {}

final class QuestionPageUpdated extends QuestionPageEvent {
  final int pageIndex;

  QuestionPageUpdated({required this.pageIndex});
}

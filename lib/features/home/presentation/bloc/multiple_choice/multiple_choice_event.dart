part of 'multiple_choice_bloc.dart';

@immutable
sealed class MultipleChoiceEvent {}

class OptionSelected extends MultipleChoiceEvent {
  final List<String> data;
  final String selectedOption;
  final int? index;

  OptionSelected({
    required this.data,
    required this.selectedOption,
    this.index,
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'multiple_choice_event.dart';
part 'multiple_choice_state.dart';

class MultipleChoiceBloc extends Bloc<MultipleChoiceEvent, List<String>> {
  MultipleChoiceBloc(int initialLength)
      : super(List<String>.generate(initialLength, (index) => '')) {
    on<OptionSelected>(_onOptionUpdated);
  }
  void _onOptionUpdated(
    OptionSelected event,
    Emitter<List<String>> emit,
  ) async {
    state[event.index ?? 0] = event.selectedOption;
    emit([...state]);
  }
}

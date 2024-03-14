import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'question_page_event.dart';

class QuestionPageBloc extends Bloc<QuestionPageEvent, int> {
  QuestionPageBloc() : super(0) {
    on<QuestionPageUpdated>((event, emit) {
      emit(event.pageIndex);
    });
  }
}

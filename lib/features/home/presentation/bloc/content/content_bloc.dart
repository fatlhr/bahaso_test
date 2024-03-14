import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/detect_content_type.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final DetectContentTypeUsecase _usecase;
  ContentBloc(this._usecase) : super(ContentLoading()) {
    on<DetectContentTypeEvent>((event, emit) async {
      emit(ContentLoading());
      try {
        final contentType = await _usecase(event.url);
        emit(ContentTypeLoaded(contentType));
      } catch (e) {
        emit(
          ContentError('Failed to detect content type: $e'),
        );
      }
    });
  }
}

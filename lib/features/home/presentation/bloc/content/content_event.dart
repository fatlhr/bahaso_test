part of 'content_bloc.dart';

@immutable
sealed class ContentEvent {}

class DetectContentTypeEvent extends ContentEvent {
  final String url;

  DetectContentTypeEvent(this.url);
}

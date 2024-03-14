part of 'content_bloc.dart';

@immutable
sealed class ContentState {}

final class ContentLoading extends ContentState {}

final class ContentTypeLoaded extends ContentState {
  final String contentType;

  ContentTypeLoaded(this.contentType);
}

final class ContentError extends ContentState {
  final String message;

  ContentError(this.message);
}

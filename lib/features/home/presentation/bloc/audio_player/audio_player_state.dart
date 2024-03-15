part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerState {}

final class AudioPlayerInitial extends AudioPlayerState {}

final class AudioPlayerPlaying extends AudioPlayerState {}

final class AudioPlayerPaused extends AudioPlayerState {}

final class AudioPlayerStopped extends AudioPlayerState {}

final class AudioPlayerLoading extends AudioPlayerState {}

final class AudioPlayerDurationChanged extends AudioPlayerState {
  final Duration duration;

  AudioPlayerDurationChanged({required this.duration});
}

final class AudioPlayerPositionChanged extends AudioPlayerState {
  final Duration position;

  AudioPlayerPositionChanged({required this.position});
}

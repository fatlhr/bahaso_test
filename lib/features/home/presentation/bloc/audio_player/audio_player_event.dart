part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerEvent {}

final class PlayerStateChangedEvent extends AudioPlayerEvent {
  final PlayerState state;

  PlayerStateChangedEvent(this.state);
}

final class DurationChangedEvent extends AudioPlayerEvent {
  final Duration duration;

  DurationChangedEvent(this.duration);
}

final class PositionChangedEvent extends AudioPlayerEvent {
  final Duration position;

  PositionChangedEvent(this.position);
}

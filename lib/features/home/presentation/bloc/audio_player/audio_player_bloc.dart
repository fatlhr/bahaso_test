import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String url;

  AudioPlayerBloc(this.url) : super(AudioPlayerInitial()) {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      add(DurationChangedEvent(newDuration));
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      add(PositionChangedEvent(newPosition));
    });

    on<PlayerStateChangedEvent>((event, emit) {
      if (event.state == PlayerState.playing) {
        _audioPlayer.play(UrlSource(url));
        emit(AudioPlayerPlaying());
      } else if (event.state == PlayerState.paused) {
        _audioPlayer.pause();
        emit(AudioPlayerPaused());
      } else if (event.state == PlayerState.stopped) {
        _audioPlayer.stop();
        emit(AudioPlayerStopped());
      }
    });

    on<DurationChangedEvent>((event, emit) {
      emit(AudioPlayerDurationChanged(duration: event.duration));
    });

    on<PositionChangedEvent>((event, emit) {
      emit(AudioPlayerPositionChanged(position: event.position));
    });
  }
}

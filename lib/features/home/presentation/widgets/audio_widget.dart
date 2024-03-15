import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_player/audio_player_bloc.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({super.key, required this.url});
  final String url;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  // @override
  // void initState() {
  //   audioPlayer.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       isPlaying = state == PlayerState.playing;
  //     });
  //   });
  //   audioPlayer.onDurationChanged.listen((newDuration) {
  //     setState(() {
  //       duration = newDuration;
  //     });
  //   });

  //   audioPlayer.onPositionChanged.listen((newPosition) {
  //     setState(() {
  //       position = newPosition;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AudioPlayerBloc(widget.url),
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
          IconData icon = Icons.play_arrow;
          Function()? onPressed = () {};

          if (state is AudioPlayerPlaying) {
            icon = Icons.pause;
            onPressed = () {
              audioPlayerBloc.add(PlayerStateChangedEvent(PlayerState.paused));
            };
          } else if (state is AudioPlayerPaused ||
              state is AudioPlayerInitial) {
            icon = Icons.play_arrow;
            onPressed = () {
              audioPlayerBloc.add(PlayerStateChangedEvent(PlayerState.playing));
            };
          }

          Duration position = Duration.zero;

          if (state is AudioPlayerPositionChanged) {
            position = state.position;
          }
          return SizedBox(
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(icon),
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: position.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (val) {},
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

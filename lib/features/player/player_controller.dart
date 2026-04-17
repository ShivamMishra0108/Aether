import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;

import 'player_state.dart';

class PlayerController extends StateNotifier<PlayerState> {
  final AudioPlayer _player = AudioPlayer();
  Timer? _timer;

  PlayerController()
      : super(const PlayerState(
          isPlaying: false,
          position: Duration.zero,
          duration: Duration.zero,
        ));

  Future<void> start(
      String audioPath, int seconds, String title) async {
    try {
      await _player.setAsset(audioPath);
      await _player.setLoopMode(LoopMode.one);

      _timer?.cancel();

      state = state.copyWith(
        audioPath: audioPath,
        totalSeconds: seconds,
        title: title,
        duration: Duration(seconds: seconds),
        position: Duration.zero,
        isPlaying: true,
      );

      await _player.play();

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        final newPosition =
            state.position + const Duration(seconds: 1);

        if (newPosition >= state.duration) {
          endSession();
        } else {
          state = state.copyWith(position: newPosition);
        }
      });
    } catch (e) {
      print("Audio error: $e"); // helps debugging
    }
  }

  void pause() {
    _player.pause();
    state = state.copyWith(isPlaying: false);
  }

  void resume() {
    _player.play();
    state = state.copyWith(isPlaying: true);
  }

  void endSession() {
    _timer?.cancel();
    _player.stop();

    state = state.copyWith(
      isPlaying: false,
      position: Duration.zero,
      title: null,
      audioPath: null,
      totalSeconds: null,
    );
  }

  @override
  void dispose() {
    _player.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
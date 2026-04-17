class PlayerState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  final String? title;
  final String? audioPath;
  final int? totalSeconds;

  const PlayerState({
    required this.isPlaying,
    required this.position,
    required this.duration,
    this.title,
    this.audioPath,
    this.totalSeconds,
  });

  PlayerState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    String? title,
    String? audioPath,
    int? totalSeconds,
  }) {
    return PlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      audioPath: audioPath ?? this.audioPath,
      totalSeconds: totalSeconds ?? this.totalSeconds,
    );
  }
}
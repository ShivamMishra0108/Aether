import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/player/player_controller.dart';
import '../../features/player/player_state.dart';

final playerProvider =
    StateNotifierProvider<PlayerController, PlayerState>(
  (ref) => PlayerController(),
);
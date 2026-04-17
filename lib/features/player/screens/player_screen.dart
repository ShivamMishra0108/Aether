import 'dart:ui';
import 'package:aether/data/models/ambience_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/player_provider.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key, required Ambience ambience});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerProvider);
    final controller = ref.read(playerProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // 🌈 Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C2A44), Color(0xFF3A4A6A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    state.title ?? "Session",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Slider(
                    value: state.position.inSeconds.toDouble(),
                    max: state.duration.inSeconds == 0
                        ? 1
                        : state.duration.inSeconds.toDouble(),
                    onChanged: (_) {},
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_format(state.position),
                          style: const TextStyle(color: Colors.white70)),
                      Text(_format(state.duration),
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: () {
                      if (state.isPlaying) {
                        controller.pause();
                      } else {
                        controller.resume();
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        state.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextButton(
                    onPressed: () => _showEndDialog(context, controller),
                    child: const Text("End Session",
                        style: TextStyle(color: Colors.white70)),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final sec = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  void _showEndDialog(BuildContext context, controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("End Session?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                controller.endSession();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("End")),
        ],
      ),
    );
  }
}
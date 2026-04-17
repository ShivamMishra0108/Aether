import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/player_provider.dart';
import '../../../data/models/journal_model.dart';
import '../journal_controller.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final controllerText = TextEditingController();
  String selectedMood = "Calm";

  final moods = ["Calm", "Grounded", "Energized", "Sleepy"];

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final journalCtrl = ref.read(journalProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Reflection")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "What is gently present with you right now?",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controllerText,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your thoughts...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 😊 Mood selector
            Wrap(
              spacing: 8,
              children: moods.map((mood) {
                return ChoiceChip(
                  label: Text(mood),
                  selected: selectedMood == mood,
                  onSelected: (_) {
                    setState(() => selectedMood = mood);
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () async {
                final entry = JournalEntry(
                  text: controllerText.text,
                  mood: selectedMood,
                  date: DateTime.now(),
                  ambience: playerState.title ?? "Session",
                );

                await journalCtrl.addEntry(entry);

                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
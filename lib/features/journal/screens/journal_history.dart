import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../journal_controller.dart';

class JournalHistoryScreen extends ConsumerWidget {
  const JournalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Journal History")),
      body: entries.isEmpty
          ? const Center(
              child: Text("No reflections yet. Start a session to begin."),
            )
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (_, i) {
                final e = entries[i];

                return ListTile(
                  title: Text(e.ambience),
                  subtitle: Text(e.text),
                  trailing: Text(e.mood),
                );
              },
            ),
    );
  }
}
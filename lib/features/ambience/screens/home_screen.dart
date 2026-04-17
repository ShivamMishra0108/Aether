import 'package:aether/features/ambience/widgets/ambience_card.dart';
import 'package:aether/features/player/screens/player_screen.dart';
import 'package:aether/shared/providers/ambience_provider.dart';
import 'package:aether/shared/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String selectedTag = "All";
  String searchQuery = "";

  final tags = ["All", "Focus", "Calm", "Sleep", "Reset"];

  @override
  Widget build(BuildContext context) {
    final ambiences = ref.watch(ambienceProvider);

    final filtered = ambiences.where((a) {
      final matchesTag =
          selectedTag == "All" || a.tag == selectedTag;

      final matchesSearch =
          a.title.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesTag && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aether"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search
            TextField(
              decoration: InputDecoration(
                hintText: "Search ambience...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() => searchQuery = val);
              },
            ),

            const SizedBox(height: 12),

            // 🏷️ Filter Chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: tags.map((tag) {
                  return CustomChip(
                    label: tag,
                    isSelected: selectedTag == tag,
                    onTap: () {
                      setState(() => selectedTag = tag);
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: filtered.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("No ambiences found"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedTag = "All";
                              searchQuery = "";
                            });
                          },
                          child: const Text("Clear Filters"),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final ambience = filtered[i];

                        return AmbienceCard(
                          ambience: ambience,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlayerScreen(
                                  ambience: ambience,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open a default box (you can create more later)
  await Hive.openBox('aetherBox');

  runApp(
    const ProviderScope(
      child: AetherApp(),
    ),
  );
}

class AetherApp extends StatelessWidget {
  const AetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aether',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = Hive.box('aetherBox');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aether'),
        centerTitle: true,
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No data yet'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index);

              return ListTile(
                title: Text(item.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => box.deleteAt(index),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          box.add("Item ${box.length + 1}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
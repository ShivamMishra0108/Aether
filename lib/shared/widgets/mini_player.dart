// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../providers/player_provider.dart';
// import '../../features/player/screens/player_screen.dart';

// class MiniPlayer extends ConsumerWidget {
//   const MiniPlayer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(playerProvider);
//     final controller = ref.read(playerProvider.notifier);

//     if (!state.isPlaying && state.position == Duration.zero) {
//       return const SizedBox();
//     }

//     final progress = state.duration.inSeconds == 0
//         ? 0.0
//         : state.position.inSeconds / state.duration.inSeconds;

//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const PlayerScreen(ambience: ambience,),
//             ),
//           );
//         },
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
//             borderRadius:
//                 const BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               LinearProgressIndicator(value: progress),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(state.title ?? "Playing..."),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                         state.isPlaying ? Icons.pause : Icons.play_arrow),
//                     onPressed: () {
//                       state.isPlaying
//                           ? controller.pause()
//                           : controller.resume();
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
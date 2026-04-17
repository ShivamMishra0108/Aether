import 'package:flutter/material.dart';
import '../../../data/models/ambience_model.dart';

class AmbienceCard extends StatelessWidget {
  final Ambience ambience;
  final VoidCallback onTap;

  const AmbienceCard({
    super.key,
    required this.ambience,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          children: [
            // 🖼 Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child: Image.asset(
                ambience.audio,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            // 📄 Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      ambience.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Tag
                    Text(
                      ambience.tag,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Duration
                    Text(
                      "${ambience.duration} min",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ➡️ Arrow
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.arrow_forward_ios, size: 16),
            )
          ],
        ),
      ),
    );
  }
}
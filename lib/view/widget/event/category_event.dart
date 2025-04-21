import 'package:flutter/material.dart';

class EventCategoryWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;

  const EventCategoryWidget({
    super.key,
    required this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                ? NetworkImage(imageUrl!)
                : null,
            radius: 28,
            child: imageUrl == null || imageUrl!.isEmpty
                ? const Icon(Icons.event)
                : null,
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 60,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
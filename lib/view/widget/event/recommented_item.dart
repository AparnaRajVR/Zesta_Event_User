import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';

class RecommendedItemsWidget extends StatelessWidget {
  final List<EventModel> events;

  const RecommendedItemsWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Recommended Events",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "See All >",
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length > 3 ? 3 : events.length, // Show up to 3 items
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            event.images?.isNotEmpty ?? false ? event.images!.first : 'https://via.placeholder.com/120x160',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.name ?? 'Unnamed Event',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.yellow),
                        Text('${event.ticketPrice?.toStringAsFixed(1) ?? 'N/A'}', // Placeholder for rating
                            style: const TextStyle(fontSize: 12)),
                        const Text(' votes', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
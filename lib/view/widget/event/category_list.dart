import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/widget/event/category_event.dart';

class CategoryListWidget extends StatelessWidget {
  final List<EventModel> events;

  const CategoryListWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventCategoryWidget(
            title: event.name ?? 'Unnamed Event',
            imageUrl: event.images != null && event.images!.isNotEmpty ? event.images!.first : null,
          );
        },
      ),
    );
  }
}
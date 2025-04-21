
// Reusable Carousel Widget
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventCarousel extends StatelessWidget {
  final List<dynamic> events;

  const EventCarousel({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: events.map((event) {
        final imageUrl =
            (event.images != null && event.images!.isNotEmpty) ? event.images!.first : '';
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Container(
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.event, size: 80)),
                ),
        );
      }).toList(),
    );
  }
}
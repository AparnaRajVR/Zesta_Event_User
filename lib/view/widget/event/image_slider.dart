import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventImageSlider extends StatelessWidget {
  final List<String> images;
  final double? height;
  final BorderRadius? borderRadius;

  const EventImageSlider({
    Key? key,
    required this.images,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        height: height ?? 180,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: const Center(child: Icon(Icons.image_not_supported, size: 60)),
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: height ?? 180,
        autoPlay: images.length > 1,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
      ),
      items: images.map((imageUrl) {
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                Container(
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 60)),
                ),
          ),
        );
      }).toList(),
    );
  }
}

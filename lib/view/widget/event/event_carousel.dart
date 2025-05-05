
// // Reusable Carousel Widget
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:zesta_1/model/event_model.dart';

// class EventCarousel extends StatelessWidget {
  
//   final List<EventModel> events;


//   const EventCarousel({Key? key, required this.events}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 190.0,
//         autoPlay: true,
//         enlargeCenterPage: true,
//       ),
//       items: events.map((event) {
//         final imageUrl =
//             (event.images != null && event.images!.isNotEmpty) ? event.images!.first : '';
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: imageUrl.isNotEmpty
//               ? Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 )
//               : Container(
//                   color: Colors.grey[300],
//                   child: const Center(child: Icon(Icons.event, size: 80)),
//                 ),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/widget/event/image_slider.dart';

class EventCarousel extends StatelessWidget {
  final List<EventModel> events;

  const EventCarousel({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: events.map((event) {
        return EventImageSlider(
          images: event.images ?? [],
          height: 190,
          borderRadius: BorderRadius.circular(12),
        );
      }).toList(),
    );
  }
}

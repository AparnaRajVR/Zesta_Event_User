
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/widget/event/image_slider.dart'; 

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({super.key, required this.event});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'No Date';
    try {
      final date = DateTime.parse(dateStr);
      final month = _getMonthName(date.month);
      final weekday = _getWeekdayName(date.weekday);
      return '$weekday, ${date.day} $month ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTimeRange(String? startTime, String? endTime) {
    if (startTime == null || startTime.isEmpty) {
      return endTime == null || endTime.isEmpty
          ? 'Time not specified'
          : 'Ends at ${_formatTime(endTime)}';
    }
    if (endTime == null || endTime.isEmpty) {
      return ' ${_formatTime(startTime)}';
    }
    return '${_formatTime(startTime)} - ${_formatTime(endTime)}';
  }

  String _formatTime(String timeStr) {
    try {
      String t = timeStr;
      if (timeStr.contains('T')) {
        t = timeStr.split('T')[1];
      }
      t = t.split('.').first;
      final parts = t.split(':');
      if (parts.length < 2) return timeStr;
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12;
      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return timeStr;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.35;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: EventImageSlider(
                      images: event.images ?? [],
                      height: imageHeight,
                      borderRadius: BorderRadius.zero, 
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name ?? 'Event Title',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Date
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              _formatDate(event.date),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Time
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              _formatTimeRange(event.startTime, event.endTime),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Duration
                        Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              event.duration != null
                                  ? 'Duration: ${event.duration}'
                                  : 'Duration not specified',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Location
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(child: Text(event.address ?? 'No Address')),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Organizer
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(' ${event.organizerName }'),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Category
                        Row(
                          children: [
                            const Icon(Icons.category, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(controller.getCategoryName(event.categoryId ?? '')),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Age Limit
                        if ((event.ageLimit?.isNotEmpty ?? false)) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.cake, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(
                                      'Age Limit: ${event.ageLimit!.join(', ')}')),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],

                        // Language
                        if ((event.languages?.isNotEmpty ?? false)) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.language, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(
                                      'Language: ${event.languages!.join(', ')}')),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],

                        const SizedBox(height: 20),

                        // Description
                        const Text(
                          'About The Event',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event.description ?? 'No Description',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Price & Book Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${event.ticketPrice?.toStringAsFixed(0) ?? '299'}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Available',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

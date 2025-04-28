import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zesta_1/model/event_model.dart';

class EventController extends GetxController {
  var events = <EventModel>[].obs;

  List<EventModel> get allEvents => events;

  // Example: filter featured events (you can adjust the logic as per your data)
  List<EventModel> get featuredEvents => events.where((e) => e.categoryId == 'featured').toList();

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  void fetchEvents() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('events').get();
    log('Firestore snapshot size: ${snapshot.docs.length}'); 

    final eventList = snapshot.docs.map((doc) {
      log('Doc data: ${doc.data()}'); 
      return EventModel.fromMap(doc.data());
    }).toList();

    events.value = eventList;
    log('Events loaded: ${events.length}');
  } catch (e) {
    log('Error fetching events: $e');
  }
}

}
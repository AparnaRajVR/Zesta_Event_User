import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/screen/entry/event_carousel.dart';
import 'package:zesta_1/view/screen/favorite_page.dart';
import 'package:zesta_1/view/screen/profile_screen.dart';
import 'package:zesta_1/view/screen/ticket_screen.dart';
import 'package:zesta_1/view/widget/event/category_event.dart';
import 'package:zesta_1/view/widget/event/featured_event.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

enum SelectedTab { home, tickets, analytics, profile }

class DashboardController extends GetxController {
  var selectedTabIndex = 0.obs;
  void onTabSelected(int index) {
    selectedTabIndex.value = index;
  }
}

class Dashboard extends StatelessWidget {
  final EventController eventController = Get.find<EventController>();
  final LocationDialogController locationController = Get.put(LocationDialogController());
  final DashboardController dashboardController = Get.put(DashboardController());

  Dashboard({super.key});

  final List<Widget> pages = [
    const TicketScreen(),
    const FavoritePage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Obx(() => Text(
              locationController.locationText.value,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (dashboardController.selectedTabIndex.value == SelectedTab.home.index) {
            if (eventController.allEvents.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventController.allEvents.length,
                        itemBuilder: (context, index) {
                          final event = eventController.allEvents[index];
                          return EventCategoryWidget(
                            title: event.name ?? '',
                            imageUrl: event.images != null && event.images!.isNotEmpty
                                ? event.images!.first
                                : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    EventCarousel(events: eventController.allEvents),
                    const SizedBox(height: 24),
                    const Text(
                      "Featured",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventController.featuredEvents.length,
                        itemBuilder: (context, index) {
                          final event = eventController.featuredEvents[index];
                          return FeaturedEventWidget(
                            title: event.name ?? '',
                            imageUrl: event.images != null && event.images!.isNotEmpty
                                ? event.images!.first
                                : null,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return pages[dashboardController.selectedTabIndex.value - 1];
          }
        }),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Obx(() => GNav(
              backgroundColor: Colors.white,
              rippleColor: AppColors.primary.withOpacity(0.2),
              hoverColor: AppColors.primary.withOpacity(0.1),
              gap: 8,
              activeColor: AppColors.primary,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.primary.withOpacity(0.1),
              color: Colors.grey[600],
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.event, text: 'Tickets'),
                GButton(icon: Icons.analytics, text: 'Analytics'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
              selectedIndex: dashboardController.selectedTabIndex.value,
              onTabChange: (index) => dashboardController.onTabSelected(index),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final LocationDialogController locationController;

  const AppBarWidget({super.key, required this.locationController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
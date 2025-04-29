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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/constant/color.dart';
// import 'package:zesta_1/view/widget/location_dialogue.dart';

// class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   final LocationDialogController locationController;

//   const AppBarWidget({super.key, required this.locationController});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.primary,
//       elevation: 0,
//       title: Row(
//         children: [
//           const Text(
//             "Begin Your Adventure!",
//             style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(width: 8),
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(30),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             "${locationController.locationText.value} ",
//             style: const TextStyle(color: Colors.white, fontSize: 14),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30); // Adjusted for location text
// }
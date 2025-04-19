// import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// // import 'package:zesta_1/view/screen/entry/login_screen.dart';
// import 'package:zesta_1/view/screen/entry/welcome.dart';



// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   void _navigate(BuildContext context) {
//     // final FirebaseAuth auth = FirebaseAuth.instance;
//     // final User? user = auth.currentUser;

//      Get.off(()=>WelcomeScreen());
//     //.................................

//     // if (user != null) {
//     //   Get.off(() => Dashboard());
//     // } else {
//     //   Get.off(() => OnboardingScreen());
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 2), () => _navigate(context));

//     return Scaffold(
//       body: Center(
//         child: Image.asset(
//           'assets/logo.png',
//           height: 150,
//           width: 150,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zesta_1/view/screen/dash_board.dart';
import 'package:zesta_1/view/screen/entry/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<User?> checkUserStatus() async {
    return FirebaseAuth.instance.authStateChanges().first;
  }

  void navigateToNextScreen(User? user) {
    if (user == null) {
      Get.offAll(() => WelcomeScreen());
    } else {
      Get.offAll(() => Dashboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: checkUserStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            // Navigate to the next screen once data is ready
            WidgetsBinding.instance.addPostFrameCallback((_) {
              navigateToNextScreen(snapshot.data);
            });

            return Center(child: Image.asset('assets/logo.png', height: 150, width: 150));
          }
        },
      ),
    );
  }
}

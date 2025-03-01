import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/services/firebase_control.dart';
import 'package:zesta_1/view/widget/otp_verify.dart';

class OtpSend extends GetWidget<FirebaseControl> {
  final TextEditingController phoneController = TextEditingController();

  OtpSend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 50),
            SizedBox(height: 20),
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter your phone number',
              style: TextStyle(fontSize: 16, color: AppColors.textaddn),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: '10 digits...',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String phoneNumber = phoneController.text.trim();

                controller.phoneAuthentication(phoneNumber).then((_) {
          
                  Get.to(() => OtpScreen());
                }).catchError((e) {
                  
                  Get.snackbar('Error', 'Something went wrong. Please try again.');
                });
              },
              child: Text('SEND OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

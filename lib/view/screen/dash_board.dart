import 'package:flutter/material.dart';
import 'package:zesta_1/constant/color.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard',style: TextStyle(color: AppColors.primary),),
      ),
    );
  }
}
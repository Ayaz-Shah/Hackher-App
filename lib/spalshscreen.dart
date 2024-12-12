// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hackher/hostScreens/onBoardingScreens/hostonboardingscreenone.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void switchRouterpage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>  HostOnBoardingScreenOne()));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), switchRouterpage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Spacer(),
            Image.asset(
              'assets/assets/logos/logo.png',
            ),

          ],
        ),
      ),
    );
  }
}

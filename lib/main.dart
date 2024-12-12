import 'package:flutter/material.dart';
import 'package:hackher/hostScreens/hostInterestScreen.dart';
import 'package:hackher/hostScreens/hostNeedScreen.dart';
import 'package:hackher/hostScreens/hostRelationtyoeScreen.dart';
import 'package:hackher/hostScreens/hostSexlifeScreen.dart';
import 'package:hackher/hostScreens/hostSymptomReliefScreen.dart';
import 'package:hackher/hostScreens/hostTouchpointScreen.dart';
import 'package:hackher/hostScreens/hostloginscreen.dart';
import 'package:hackher/hostScreens/onBoardingScreens/hostonboardingscreenone.dart';
import 'package:hackher/spalshscreen.dart';

import 'hostScreens/hostAnimal&petsScreen.dart';
import 'hostScreens/hostDashboardscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hackher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff216d8a)),
        useMaterial3: true,
      ),
      home: HostSymptomReliefScreen(),
    );
  }
}
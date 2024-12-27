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
import 'package:shared_preferences/shared_preferences.dart';

import 'hostScreens/HostRegisterScreen.dart';
import 'hostScreens/hostAnimal&petsScreen.dart';
import 'hostScreens/hostDashboardscreen.dart';
import 'hostScreens/hostProfileScreen.dart';
import 'hostScreens/hstWishlistScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: FutureBuilder<bool>(
        future: checkLoginState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // Navigate based on login state
              final isLoggedIn = snapshot.data ?? false;
              return isLoggedIn ? HostDashBoardScreen() : SplashScreen();
            } else {
              // Handle error or fallback screen if needed
              return HostLoginScreen();
            }
          } else {
            // Show loading indicator while checking login state
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<bool> checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

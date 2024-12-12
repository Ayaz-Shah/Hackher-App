import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/onBoardingScreens/hostonboardingscreentwo.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';

class HostOnBoardingScreenOne extends StatelessWidget {
  const HostOnBoardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 130,),
              Container(
                width: 308,
                height: 265,
                child: Image.asset(
                  "assets/assets/hostonboarding-image/hostonboardimage1.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 274,
                  height: 115,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Lorem ipsum dolor",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff172951),
                              letterSpacing: -0.3,
                              height: 1.5),
                        ),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet consectetur. Ut\n eget facilisis aliquam eget natoque ut",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff172951),
                          letterSpacing: -0.3,
                          height: 23.18 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                  width: 253,
                  height: 50,
                  child: CustomElevatedButton(
                      label: "Get Started",  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HostOnBoardingScreenTwo()));
                  },)),
              SizedBox(height: 10,),
              InkWell(
                child: Text("Skip",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff222222)
                ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

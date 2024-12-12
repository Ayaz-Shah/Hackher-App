import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';

import 'HostRegisterScreen.dart';
import 'widgets/HostCustomTextFeildwidgets.dart';

class HostLoginScreen extends StatefulWidget {
  const HostLoginScreen({super.key});

  @override
  State<HostLoginScreen> createState() => _HostLoginScreenState();
}

class _HostLoginScreenState extends State<HostLoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 114.5,
                  width: 200.8,
                  child: Image.asset(
                    'assets/assets/logos/authentication-logo.png',
                    // Replace with your logo asset pat
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 82,
                    width: 280,
                    child: Column(
                      children: [
                        Text(
                          'Welcome back',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff172951)),
                        ),
                        Text(
                          "You can search course, apply course and find \n scholorship for abroad studies",
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
                SizedBox(height: 10),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: 'Email',
                          labelStyle: GoogleFonts.rubik(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          labelColor: const Color(0xff222222),
                          hintText: 'user@email.com',
                          suffixIcon: Icons.done,
                          keyboardType: TextInputType.emailAddress, // Optional if needed
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          labelStyle: GoogleFonts.rubik(
                              fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'Enter your password',
                          isPassword: true,
                          isObscure: true,
                          suffixIcon: Icons.visibility_off,
                          keyboardType: TextInputType.text,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostLoginScreen()));
                              },
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    fontSize: 14.0,
                                    color: Color(
                                      0xff222222,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: 253,
                            height: 50,
                            child: CustomElevatedButton(
                              label: "Login",
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostLoginScreen()));
                              },
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '-----------Or-----------',
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                              fontSize: 16.0,
                              color: Color(
                                0xff222222,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFFFFFF), // Button background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Rounded corners
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/assets/icons/google-icon.png"),
                                    SizedBox(width: 10,),
                                    Text(
                                      'Google',
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.0,
                                          color: Color(
                                            0xff677294,
                                          )),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HostRegisterScreen()));
                      },
                      child: Text(
                        "Don't have an account? Join us",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            fontSize: 14.0,
                            color: Color(
                              0xff222222,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

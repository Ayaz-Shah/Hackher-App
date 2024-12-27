import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/hostDashboardscreen.dart';
import 'package:hackher/hostScreens/hostForgotScreen.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'HostRegisterScreen.dart'; // Import your model
import 'package:shared_preferences/shared_preferences.dart';  // Import shared_preferences

class HostLoginScreen extends StatefulWidget {
  const HostLoginScreen({super.key});

  @override
  State<HostLoginScreen> createState() => _HostLoginScreenState();
}

class _HostLoginScreenState extends State<HostLoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for email and password
  final TextEditingController hostEmailController = TextEditingController();
  final TextEditingController hostPasswordController = TextEditingController();

  // Hard-coded values for device_type and device_token
  final String deviceType = "android"; // or "ios" depending on your app
  final String deviceToken = "your-device-token-here";


  // Function to get token from SharedPreferences
  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('auth_token');
  // }
  // Function to handle login
  Future<void> saveLoginState(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setBool('isLoggedIn', true);
    print('Login state and token saved.');
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      final String email = hostEmailController.text;
      final String password = hostPasswordController.text;

      final String apiUrl = 'https://hacker.devssh.xyz/host/v1/auth/login/';

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
            'password': password,
            'device_type': deviceType,
            'device_token': deviceToken,
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          await saveLoginState(data['token']);
          Fluttertoast.showToast(
            msg: "Login successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Color(0xff216D8A),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HostDashBoardScreen()),
                (route) => false,
          );
        } else {
          final errorData = json.decode(response.body);
          String errorMessage = "Unknown error";

          if (errorData.containsKey('email')) {
            errorMessage = "User does not exist. Please check the email.";
          } else if (errorData.containsKey('password')) {
            errorMessage = "Incorrect password. Please try again.";
          } else if (errorData.containsKey('error')) {
            errorMessage = errorData['error'];
          }

          Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "An error occurred: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

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
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 114.5,
                  width: 200.8,
                  child: Image.asset(
                    'assets/assets/logos/authentication-logo.png',
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
                            color: Color(0xff172951),
                          ),
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
                        // Email Text Field
                        CustomTextFormField(
                          controller: hostEmailController,
                          label: 'Email',
                          labelStyle: GoogleFonts.rubik(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          labelColor: const Color(0xff222222),
                          hintText: 'user@email.com',
                          suffixIcon: Icons.done,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Regular expression to validate email format
                            if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        // Password Text Field
                        CustomTextFormField(
                          controller: hostPasswordController,
                          label: 'Password',
                          labelStyle: GoogleFonts.rubik(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          labelColor: Color(0xff222222),
                          hintText: 'Enter your valid password',
                          isPassword: true,
                          isObscure: true,
                          suffixIcon: Icons.visibility_off,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your valid password';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HostForggotScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  fontSize: 14.0,
                                  color: Color(0xff222222),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: 253,
                          height: 50,
                          child: CustomElevatedButton(
                            label: "Login",
                            onPressed: ()  {
                              login();
                            }, // Call the login function on press
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          '-----------Or-----------',
                          style: GoogleFonts.rubik(fontWeight: FontWeight.w300, fontSize: 16.0, color: Color(0xff222222)),
                        ),
                        SizedBox(height: 30),
                        // Google Sign Up Button
                        Container(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/assets/icons/google-icon.png"),
                                SizedBox(width: 10),
                                Text(
                                  'Google',
                                  style: GoogleFonts.rubik(fontWeight: FontWeight.w300, fontSize: 16.0, color: Color(0xff677294)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70),
                // Login Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HostRegisterScreen()),
                        );
                      },
                      child: Text(
                        "have an account? Join us",
                        style: GoogleFonts.rubik(fontWeight: FontWeight.w400, letterSpacing: 0.5, fontSize: 14.0, color: Color(0xff222222)),
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

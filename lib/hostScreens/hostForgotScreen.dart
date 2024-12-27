import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'hostOtpScreen.dart'; // Import your HostOtpScreen here

class HostForggotScreen extends StatefulWidget {
  const HostForggotScreen({super.key});

  @override
  State<HostForggotScreen> createState() => _HostForggotScreenState();
}

class _HostForggotScreenState extends State<HostForggotScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController hostEmailController = TextEditingController();

  // Email Validation Function
  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  // Send OTP Function
  Future<void> sendOtp(String email) async {
    final url = Uri.parse('https://hacker.devssh.xyz/host/v1/auth/send_forget_otp/');
    try {
      // Show a loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // API call
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email.trim()}),
      );

      // Log the response
      final data = jsonDecode(response.body);
      print('API Response: $data'); // Log the response

      // Close the loading dialog
      Navigator.pop(context);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP sent successfully to your email.",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );

        // Navigate to OTP Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HostOtpScreen(email: email)),
        );
      } else {
        // Show error message for non-200 response
        Fluttertoast.showToast(
          msg: 'Error: This email not found',
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );
      }
    } catch (e) {
      // Dismiss the loading indicator in case of error
      Navigator.pop(context);
      print('Error: $e'); // Log the error
      Fluttertoast.showToast(
        msg: 'An error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Color(0xff216D8A),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/assets/logos/authentication-logo.png',
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'No worries! You can easily reset your password here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
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
                            return 'Email is required.';
                          } else if (!isValidEmail(value.trim())) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String email = hostEmailController.text.trim();
                              sendOtp(email);
                              hostEmailController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff216D8A),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Reset',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

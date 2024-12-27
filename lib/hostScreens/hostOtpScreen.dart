import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/hostResetScreen.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';  // Import fluttertoast package

class HostOtpScreen extends StatefulWidget {
  final String email; // Declare a final variable for the email

  // Constructor to accept the email
  const HostOtpScreen({super.key, required this.email});

  @override
  State<HostOtpScreen> createState() => _HostOtpScreenState();
}

class _HostOtpScreenState extends State<HostOtpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController hostOtpController =
  TextEditingController(); // OTP Controller

  // Function to verify OTP
  Future<void> verifyOtp(String otp) async {
    final url = Uri.parse(
        'https://hacker.devssh.xyz/host/v1/auth/verify_otp/'); // Corrected API URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
          'otp': otp,
        }),
      );

      print('Verify OTP Response Status: ${response.statusCode}');
      print('Verify OTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP Verified Successfully",  // Success message
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HostResetPasswordScreen(email:widget.email,)),
              (route) => false,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Invalid OTP. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      Fluttertoast.showToast(
        msg: "An error occurred while verifying OTP.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Color(0xff216D8A),
      );
    }
  }

  // Function to resend OTP
  Future<void> resendOtp() async {
    final url = Uri.parse(
        'https://hacker.devssh.xyz/host/v1/auth/send_forget_otp/'); // Corrected API URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
        }),
      );

      print('Resend OTP Response Status: ${response.statusCode}');
      print('Resend OTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP Resent Successfully to your email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );

        hostOtpController.clear();
      } else {
        Fluttertoast.showToast(
          msg: "Failed to resend OTP.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );
      }
    } catch (e) {
      print('Error during OTP resend: $e');
      Fluttertoast.showToast(
        msg: "An error occurred while resending OTP.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
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
        iconTheme: IconThemeData(color: Colors.black),
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
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'We have sent an OTP to ${widget.email}. Please enter the OTP below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
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
                          label: 'OTP',
                          controller: hostOtpController,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          labelColor: Color(0xff216D8A),
                          hintText: 'Enter OTP',
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 40),
                        // Verify Button
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (hostOtpController.text.isNotEmpty) {
                                await verifyOtp(hostOtpController.text.trim());
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please enter the OTP.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff216D8A),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                              ),
                            ),
                            child: Text(
                              'Verify',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFFFFF), // Text color is white
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Resend Button
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await resendOtp();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff216D8A),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                              ),
                            ),
                            child: Text(
                              'Resend',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFFFFF), // Text color is white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

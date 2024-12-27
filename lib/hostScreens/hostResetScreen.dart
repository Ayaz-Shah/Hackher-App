import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackher/hostScreens/hostloginscreen.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HostResetPasswordScreen extends StatefulWidget {
  final String email; // Email passed from OTP screen

  const HostResetPasswordScreen({super.key, required this.email});

  @override
  State<HostResetPasswordScreen> createState() =>
      _HostResetPasswordScreenState();
}

class _HostResetPasswordScreenState extends State<HostResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController hostpasswordController = TextEditingController();
  final TextEditingController hostconfirmPasswordController =
  TextEditingController();

  Future<void> handleUpdateButton() async {
    String newPassword = hostpasswordController.text.trim();
    String confirmPassword = hostconfirmPasswordController.text.trim();

    // Check if passwords are filled
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(
        msg: "Both password fields are required!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
      return;
    }

    // Check if passwords match
    if (newPassword != confirmPassword) {
      Fluttertoast.showToast(
        msg: "Passwords do not match!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // Make API call to update password
    final url = Uri.parse('https://hacker.devssh.xyz/host/v1/auth/update_password/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": widget.email, // Use email passed from OTP screen
          "newpassword": newPassword,
        }),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Password updated successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HostLoginScreen()),
              (Route<dynamic> route) => false,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to update password. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Image.asset(
                  'assets/assets/logos/authentication-logo.png',
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text(
                  'Please enter your new password below!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: hostpasswordController,
                        label: 'Password',
                        labelStyle: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                        labelColor: Color(0xff222222),
                        hintText: 'Enter your password',
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        isObscure: true,
                        suffixIcon: Icons.visibility_off,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: hostconfirmPasswordController,
                        label: 'Confirm Password',
                        labelStyle: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                        labelColor: Color(0xff222222),
                        hintText: 'Confirm your password',
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        isObscure: true,
                        suffixIcon: Icons.visibility_off,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: handleUpdateButton,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff216D8A),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Update',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFFFFF),
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

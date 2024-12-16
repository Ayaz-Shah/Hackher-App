import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../HostModels/HostSignUpModel.dart';
import 'hostloginscreen.dart';

class HostRegisterScreen extends StatefulWidget {
  const HostRegisterScreen({super.key});

  @override
  State<HostRegisterScreen> createState() => _HostRegisterScreenState();
}

class _HostRegisterScreenState extends State<HostRegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController hostfnameController = TextEditingController();
  TextEditingController hostlnameController = TextEditingController();
  TextEditingController hostemailController = TextEditingController();
  TextEditingController hostpasswordController = TextEditingController();

  String? _selectedOption;
  final FocusNode hfnameFocus = FocusNode();
  final FocusNode hlnameFocus = FocusNode();
  final FocusNode hemailFocus = FocusNode();
  final FocusNode hpasswordFocus = FocusNode();
  final String baseUrl = "https://hacker.devssh.xyz/"; // Replace with your API URL

  // Function to handle Sign Up
  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      // Create an instance of HostSignUpModel
      final HostSignUpModel signUpModel = HostSignUpModel(
        fname: hostfnameController.text,
        lname: hostlnameController.text,
        email: hostemailController.text,
        password: hostpasswordController.text,
        role: 'host',
        dob: '11-08-2001', // You may want to get this dynamically as well
        isMenopause: _selectedOption == "Yes" ? 'true' : 'false',
        deviceType: 'ios',
        deviceToken: 'vwevwvwevvweew',
        city: 'sindh',
        state: 'Pakistan',
        country: 'Pakistan',
        gender: 'male',
        address: '4 Tariq Rd, PECHS, Karachi, 75400, Sindh, Pakistan',
        contact: '03363034894',
      );

      try {
        final response = await http.post(
          Uri.parse("$baseUrl/host/v1/auth/signup/"), // API endpoint
          headers: {
            "Content-Type": "application/json", // Set content type to JSON
          },
          body: jsonEncode(signUpModel.toJson()), // Encode data as JSON
        );

        if (response.statusCode == 200) {
          // If the server returns a success response
          final responseBody = jsonDecode(response.body);
          final HostSignUpModel responseModel = HostSignUpModel.fromJson(responseBody);

          // Show a success message on screen (Snackbar)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account created successfully!')),
          );

          // Log the message in the terminal
          print('Account created successfully: ${responseModel.toJson()}');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HostLoginScreen()), // Navigate to Login screen
          );
        } else {
          // If the server returns an error response
          final responseBody = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseBody['message'] ?? 'Something went wrong!'),
          ));
        }
      } catch (e) {
        // Catch any errors, such as connection issues
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to connect to the server!"),
        ));
        print("Error occurred: $e"); // Log the error for debugging
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 54,
                      width: 120,
                      child: Image.asset(
                        'assets/assets/logos/authentication-logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                // Title and Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 82,
                    width: 280,
                    child: Column(
                      children: [
                        Text(
                          'Sign Up',
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
                // Form for user input
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: hostfnameController,
                          label: 'First Name',
                          labelStyle: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'Enter your first name',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(hlnameFocus);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 4) {
                              return 'First name must be at least 4 characters in length';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: hostlnameController,
                          label: 'Last Name',
                          labelStyle: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'Enter your last name',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(hemailFocus);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 4) {
                              return 'Last name must be at least 4 characters in length';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: hostemailController,
                          label: 'Email',
                          labelStyle: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'user@email.com',
                          prefixIcon: Icons.email,
                          suffixIcon: Icons.done,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(hpasswordFocus);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 8) {
                              return 'Password must be at least 8 characters in length';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // Menopause Radio Option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Did you get your periods last year or not?",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            Radio<String>(
                              value: "Yes",
                              groupValue: _selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              },
                            ),
                            Text("Yes", style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300)),
                            const SizedBox(width: 15),
                            Radio<String>(
                              value: "No",
                              groupValue: _selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              },
                            ),
                            Text("No", style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300)),
                          ],
                        ),
                        SizedBox(height: 30),
                        // Sign Up Button
                        Container(
                          width: 253,
                          height: 50,
                          child: CustomElevatedButton(
                            label: "Sign Up",
                            onPressed: () {
                              signUp();
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => HostLoginScreen()),
                              //   (route) => false,
                              // );
                            },
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
                          MaterialPageRoute(builder: (context) => HostLoginScreen()),
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

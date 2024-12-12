import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';

import 'hostloginscreen.dart';

class HostRegisterScreen extends StatefulWidget {
  const HostRegisterScreen({super.key});

  @override
  State<HostRegisterScreen> createState() => _HostRegisterScreenState();
}

class _HostRegisterScreenState extends State<HostRegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  String? _selectedOption;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 54,
                      width: 120,
                      child: Image.asset(
                        'assets/assets/logos/authentication-logo.png',
                        // Replace with your logo asset pat
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: 'First Name',
                          labelStyle: GoogleFonts.rubik(
                              fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'Enter your first name',
                          keyboardType: TextInputType.text,
                        ),
                        CustomTextFormField(
                          label: 'Last Name',
                          labelStyle: GoogleFonts.rubik(
                              fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'Enter your last name',
                          keyboardType: TextInputType.text,
                        ),
                        CustomTextFormField(
                          label: 'Email',
                          labelStyle: GoogleFonts.rubik(
                              fontSize: 16, fontWeight: FontWeight.w300),
                          labelColor: Color(0xff222222),
                          hintText: 'user@email.com',
                          suffixIcon: Icons.done,
                          keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Did you get your periods last year or not?",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300,),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            // Yes option
                            Radio<String>(
                              value: "Yes", // Value for "Yes"
                              groupValue: _selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value; // Update selected option
                                });
                              },
                            ),
                            Text(
                              "Yes",
                              style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(width: 15), // Space between buttons

                            // No option
                            Radio<String>(
                              value: "No", // Value for "No"
                              groupValue: _selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value; // Update selected option
                                });
                              },
                            ),
                            Text(
                              "No",
                              style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w300),
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
                              label: "Sign Up",
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
                                  backgroundColor: Color(0xffFFFFFF),
                                  // Button background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/assets/icons/google-icon.png"),
                                    SizedBox(
                                      width: 10,
                                    ),
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
                                    HostLoginScreen()));
                      },
                      child: Text(
                        "have an account? Join us",
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

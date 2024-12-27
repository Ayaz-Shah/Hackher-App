import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/hostDashboardscreen.dart';
import 'package:hackher/hostScreens/widgets/HostCustomTextFeildwidgets.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To handle JSON parsing
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'hostloginscreen.dart';

class HostProfileScreen extends StatefulWidget {
  const HostProfileScreen({super.key});

  @override
  State<HostProfileScreen> createState() => _HostProfileScreenState();
}

class _HostProfileScreenState extends State<HostProfileScreen> {
  bool _isLoading = true;
  bool _isEditing = false; // Flag to toggle edit mode
  int _selectedIndex = 1;
  String? firstName;
  String? lastName;
  String? email;
  String? contact;
  String? address;
  String? city;
  String? country;
  String? state;
  String? dob;
  String? gender;
  String? age;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) { // If Profile tab is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HostDashBoardScreen()),
      );
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Save login state
  Future<void> saveLoginState(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setBool('isLoggedIn', true);
    print('Login state and token saved.');
  }

  // Logout function
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Remove the token
    await prefs.setBool('isLoggedIn', false); // Set login state to false
    print('Logout successful. Login state cleared.');
    // Optionally, navigate to login screen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HostLoginScreen()),
    );
  }

  // Fetch Profile Data
  Future<void> fetchProfile() async {
    String? token = await getToken();
    if (token == null) {
      return;
    }

    final response = await http.get(
      Uri.parse('https://hacker.devssh.xyz/host/v1/auth/get_profile/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          firstName = data['data']['fname'] ?? '';
          lastName = data['data']['lname'] ?? '';
          email = data['data']['email'] ?? '';
          contact = data['data']['contact'] ?? '';
          gender = data['data']['gender'] ?? '';
          address = data['data']['address'] ?? '';
          city = data['data']['city'] ?? '';
          country = data['data']['country'] ?? '';
          state = data['data']['state'] ?? '';
          age = data['data']['age'] != null ? data['data']['age'].toString() : '';
          dob = data['data']['dob'] ?? '';
          _isLoading = false;

          // Initialize controllers with fetched data
          firstNameController.text = firstName ?? '';
          lastNameController.text = lastName ?? '';
          emailController.text = email ?? '';
          contactController.text = contact ?? '';
          addressController.text = address ?? '';
          cityController.text = city ?? '';
          countryController.text = country ?? '';
          stateController.text = state ?? '';
          dobController.text = dob ?? '';
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Update Profile Data
  Future<void> updateProfile() async {
    String? token = await getToken();
    if (token == null) {
      return;
    }

    final response = await http.put(
      Uri.parse('https://hacker.devssh.xyz/host/v1/auth/update_profile/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'fname': firstNameController.text,
        'lname': lastNameController.text,
        'email': emailController.text,
        'contact': contactController.text,
        'address': addressController.text,
        'city': cityController.text,
        'country': countryController.text,
        'state': stateController.text,
        'dob': dobController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Profile updated successfully
      Fluttertoast.showToast(
        msg: "Profile updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Color(0xff216D8A),
      );

      // Fetch the latest profile data to reflect the changes
      fetchProfile();

      setState(() {
        _isEditing = false; // Disable editing after successful update
      });
    } else {
      Fluttertoast.showToast(
        msg: "Failed to update profile",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  void initState() {
    super.initState();
    fetchProfile(); // Fetch profile data when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
        backgroundColor: Color(0xffFFFFFF),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator() // Show loading indicator while fetching
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                // Full Name
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditing = true; // Enable editing when tapped
                    });
                  },
                  child: _isEditing
                      ? Row(
                    children: [
                      // First Name Field
                      Expanded(
                        child: CustomTextFormField(
                          controller: firstNameController,
                          hintText: firstName ?? 'Loading...',
                          prefixIcon: Icons.person,
                          enabled: _isEditing,
                        ),
                      ),
                      SizedBox(width: 10),
                      // Last Name Field
                      Expanded(
                        child: CustomTextFormField(
                          controller: lastNameController,
                          hintText: lastName ?? 'Loading...',
                          prefixIcon: Icons.person,
                          enabled: _isEditing,
                        ),
                      ),
                    ],
                  )
                      : Text(
                    "${firstName ?? 'Loading...'} ${lastName ?? 'Loading...'}",
                    style: GoogleFonts.inter(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Email (Editable when editing)
                CustomTextFormField(
                  controller: emailController,
                  hintText: email ?? 'Loading...',
                  prefixIcon: Icons.mail,
                  enabled: _isEditing,
                ),
                // Contact (Editable when editing)
                CustomTextFormField(
                  controller: contactController,
                  hintText: contact ?? 'Loading...',
                  prefixIcon: Icons.phone,
                  enabled: _isEditing,
                ),
                // DOB (Editable when editing)
                CustomTextFormField(
                  controller: dobController,
                  hintText: dob ?? 'Loading...',
                  prefixIcon: Icons.calendar_month,
                  enabled: _isEditing,
                ),
                // Address (Editable when editing)
                CustomTextFormField(
                  controller: addressController,
                  hintText: address ?? 'Loading...',
                  prefixIcon: Icons.home,
                  enabled: _isEditing,
                ),
                // City (Editable when editing)
                CustomTextFormField(
                  controller: cityController,
                  hintText: city ?? 'Loading...',
                  prefixIcon: Icons.location_city_outlined,
                  enabled: _isEditing,
                ),
                // Country (Editable when editing)
                CustomTextFormField(
                  controller: countryController,
                  hintText: country ?? 'Loading...',
                  prefixIcon: Icons.location_city_outlined,
                  enabled: _isEditing,
                ),
                // State (Editable when editing)
                CustomTextFormField(
                  controller: stateController,
                  hintText: state ?? 'Loading...',
                  prefixIcon: Icons.flag_circle,
                  enabled: _isEditing,
                ),
                SizedBox(height: 10),
                // Edit Profile Button
                if (!_isEditing)
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: CustomElevatedButton(
                      label: "Edit Profile",
                      onPressed: () {
                        setState(() {
                          _isEditing = true; // Enable editing
                        });
                      },
                    ),
                  ),
                if (_isEditing)
                // Save Button when editing
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: CustomElevatedButton(
                      label: "Save",
                      onPressed: updateProfile,
                    ),
                  ),
                SizedBox(height: 10),
                // Logout Button
                Container(
                  width: double.infinity,
                  height: 50,
                  child: CustomElevatedButton(
                    label: "Logout",
                    onPressed: () async {
                      await logout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF2E6F8E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 26,
              color: _selectedIndex == 0 ? Colors.white : Colors.black54,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 26,
              color: _selectedIndex == 1 ? Colors.white : Colors.black54,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

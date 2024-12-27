import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/custonNeedbuttonwidgets.dart'; // Make sure this widget is properly imported
import 'widgets/hostCustomButtonwidgets.dart'; // Make sure this widget is properly imported

class HostNeedsScreen extends StatefulWidget {
  @override
  _HostNeedsScreenState createState() => _HostNeedsScreenState();
}

class _HostNeedsScreenState extends State<HostNeedsScreen> {
  double _sliderPosition = 0.5;
  String _sliderValue = "Neutral"; // Stores selected item IDs
  List<Map<String, dynamic>> currentNeeds =
      []; // To store the options from the first API
  List<Map<String, dynamic>> selectedNeeds = []; // To store selected needs
  List<Map<String, dynamic>> hostCurrentNeeds =
      []; // To store options from the new API

  // Function to get token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Fetch needs from the first API (current needs)
  Future<void> fetchCurrentNeeds() async {
    try {
      final token = await getToken();
      if (token == null) {
        print('No token found. User might not be logged in.');
        return;
      }

      final response = await http.get(
        Uri.parse('https://hacker.devssh.xyz/host/v1/about/current_needs/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Fetched data from current needs API: $responseData");

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('options')) {
          final options = responseData['options'] as List;

          setState(() {
            currentNeeds = options
                .map((item) => {
                      'name': item['name'].toString(),
                      'id': item['id'].toString(),
                    })
                .toList();
          });

          // Fetch data from the new API after current needs are fetched
          fetchHostCurrentNeeds(token);
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print(
            'Failed to fetch current needs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching current needs: $e');
    }
  }

  // Fetch options from the new API (to check which ones are selected)
  Future<void> fetchHostCurrentNeeds(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://hacker.devssh.xyz/host/v1/add_about/get_current_needs/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Print the raw response body for debugging

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('host_needs')) {
          final options = responseData['host_needs'] as List;

          setState(() {
            // Add the fetched options to the options list
            hostCurrentNeeds = options
                .map((item) => {
                      'name': item['name'].toString(),
                      'id': item['id'].toString(),
                    })
                .toList();

            // Mark the selected options based on their IDs
            selectedNeeds = currentNeeds.where((need) {
              return hostCurrentNeeds
                  .any((newOption) => newOption['id'] == need['id']);
            }).toList();
          });
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print(
            'Failed to fetch options from new API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching options from new API: $e');
    }
  }

  // Toggling need selection
  void toggleNeed(Map<String, dynamic> need) {
    setState(() {
      if (selectedNeeds.any((s) => s['id'] == need['id'])) {
        selectedNeeds.removeWhere((s) => s['id'] == need['id']);
      } else {
        selectedNeeds.add(need);
      }
    });
  }

  // Function to post selected needs with full data (id and name) to the API
  Future<void> postCurrentNeeds() async {
    try {
      final token = await getToken();
      if (token == null) {
        print('No token found. User might not be logged in.');
        return;
      }

      // Prepare the list of selected need IDs (as strings)
      List<String> selectedNeedIds =
          selectedNeeds.map((e) => e['id'].toString()).toList();

      // Prepare request body in the correct format
      final Map<String, dynamic> requestBody = {
        'needs': selectedNeedIds, // Just the list of IDs as strings
      };

      final response = await http.post(
        Uri.parse('https://hacker.devssh.xyz/host/v1/add_about/current_needs/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Current needs successfully updated!');
        print('Response: $responseData');
      } else {
        print(
            'Failed to update current needs. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error posting current needs: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentNeeds(); // Fetch needs when the screen loads
  }

  // Build the needs grid with CustomNeedButton for toggles
  Widget _buildCurrentNeedsList() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: currentNeeds.map((need) {
        return CustomNeedButton(
          label: need['name'],
          isSelected: selectedNeeds.any((s) => s['id'] == need['id']),
          onPressed: () => toggleNeed(need),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 12),
        ),
        title: Text(
          'What Are Your Current Needs?',
          style: GoogleFonts.inter(
            fontSize: 15.25,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the toggle buttons for current needs
              if (currentNeeds.isNotEmpty) _buildCurrentNeedsList(),
              SizedBox(height: 30),
              Text(
                'What is your sex drive today?',
                style: GoogleFonts.inter(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  // Gradient background track
                  Container(
                    height: 8, // Adjusted height for the track
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF6B00), // Orange for active part
                          Color(0xFF07AEF6), // Blue for inactive part
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // Transparent Slider for interaction
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8,
                      thumbColor: Colors.white,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                      overlayColor: Color(0xFFFF6B00).withOpacity(0.3),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
                      inactiveTrackColor: Colors.transparent,
                      activeTrackColor: Colors.transparent,
                    ),
                    child: Slider(
                      value: _sliderPosition,
                      min: 0.0,
                      max: 1.0,
                      divisions: 2,
                      onChanged: (double value) {
                        setState(() {
                          _sliderPosition = value;
                          _sliderValue = value == 0.0
                              ? "No"
                              : value == 0.5
                                  ? "Neutral"
                                  : "Yes";
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'No',
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff09AFF5),
                      ),
                    ),
                    Text(
                      'Neutral',
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFF6B00),
                      ),
                    ),
                    Text(
                      'Yes!',
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff07AEF6),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 48,
                  width: 225,
                  child: CustomElevatedButton(
                    onPressed: () {
                      // Call the postCurrentNeeds function when the "Complete" button is pressed
                      postCurrentNeeds();
                    },
                    label: "Complete",
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
